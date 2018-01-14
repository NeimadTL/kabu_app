require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:user) { 
    User.create!(email: "something@gmail.com", password: "12345678", 
      password_confirmation: "12345678", for_business: false)
  }
  let(:agriculture) { Category.create!(name: 'AGRICULTURE') }
  let(:service) {
    Service.create!(title: 'Prestation d\'agriculture', 
    description: 'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,
    when an unknown printer took a galley of type and scrambled it to make a type specimen book.
    It has survived not only five centuries, but also the leap into electronic typesetting, 
    remaining essentially unchanged. It was popularised in the 1960s with the release of 
    Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing 
    software like Aldus PageMaker including versions of Lorem Ipsum.',
    price: '9.9', category_id: agriculture.id)
  }
  
  describe "when POST create" do
    subject { user }

    before do
      sign_in(user, nil)
      post :create, service_id: service.id, comment: { score: '4', content: 'awesome' } 
    end

    it "with authorised logged in user and good params, returns redirect" do
      expect(flash[:notice]).to match('Commentaire ajouté')
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(service_path(service))
    end      

    it "with authorised logged in user and bad params, returns redirect and shows error messasge" do
      post :create, service_id: service.id, comment: { score: nil, content: nil }
      expect(flash[:alert][0]).to match("Score can't be blank")
      expect(flash[:alert][1]).to match("Score is not a number")
      expect(flash[:alert][2]).to match("Score is not included in the list")
      expect(flash[:alert][3]).to match("Content can't be blank")
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(service_path(service))
    end

    it "with unauthorized logged in user and good params, returns http unauthorized" do
      sign_out(user)
      User.find(user.id).update_attributes(for_business: true)
      sign_in(user, nil)
      post :create, service_id: service.id, comment: { score: '4', content: 'awesome' } 
      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to eq "Unauthorized"
    end

    it "with no user logged in,returns http redirect" do
      sign_out(user)
      post :create, service_id: service.id, comment: { score: '4', content: 'awesome' } 
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(new_user_session_path)
    end
    
  end

end
