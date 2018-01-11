require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do

  let(:user) { 
    User.create!(email: "something@gmail.com", password: "12345678", password_confirmation: "12345678")
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
      post :create, service_id: service.id
    end

    it "returns http redirect and redirects to root path" do
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(service_path(service))
    end


    describe "and when DELETE destroy" do
      before { delete :destroy, id: service.id }

      it "returns http redirect and redirects to root path" do
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(service_path(service))
      end
    end
  end


  describe "when GET #index" do

    before do
      sign_in(user, nil)
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end


end
