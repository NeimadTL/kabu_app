require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do

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
    
    before do
      sign_in(user, nil)
      post :create, service_id: service.id
    end

    it "with authorised logged in user, returns http redirect and redirects to root path" do
      expect(Favorite.exists?(user_id: user.id, service_id: service.id)).to eq true
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(service_path(service))
    end

    it "with unauthorized logged in user, returns http unauthorized" do
      sign_out(user) # don't know why I should do that
      User.find(user.id).update_attributes(for_business: true)
      sign_in(user, nil)
      post :create, service_id: service.id
      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to eq "Unauthorized"
    end

    describe "with no user logged in," do

      before do
        sign_out(user)
      end

      it "returns http redirect" do
        post :create, service_id: service.id
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  describe "and when DELETE destroy" do
    before do
      sign_in(user, nil)
      post :create, service_id: service.id
    end

    it "returns http redirect and redirects to root path" do
      delete :destroy, id: service.id
      expect(Favorite.exists?(user_id: user.id, service_id: service.id)).to eq false
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(service_path(service))
    end

    it "with unauthorized logged in user, returns http unauthorized" do
      sign_out(user) # don't know why I should do that
      User.find(user.id).update_attributes(for_business: true)
      sign_in(user, nil)
      delete :destroy, id: service.id
      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to eq "Unauthorized"
    end

    describe "with no user logged in," do
      before do
        sign_out(user)
      end

      it "returns http redirect" do
        delete :destroy, id: service.id
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end



  describe "when GET #index" do

    before do
      sign_in(user, nil)
      get :index
    end

    it "with authorised logged in user, returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "with unauthorized logged in user, returns http unauthorized" do
      sign_out(user) # don't know why I should do that
      User.find(user.id).update_attributes(for_business: true)
      sign_in(user, nil)
      get :index
      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to eq "Unauthorized"
    end


    describe "with no user logged in," do

      before do
        sign_out(user)
      end

      it "returns http redirect" do
        get :index
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


end
