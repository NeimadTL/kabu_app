require 'rails_helper'

RSpec.describe Business::ServicesController, type: :controller do

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
    price: '9.9', category_id: agriculture.id, user_id: user.id)
  }


  describe "when GET #index" do

    before do
      sign_in(user, nil)
    end

    it "with logged in user, returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    describe "with no user is logged in," do

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


  describe "when GET #new" do

    before do
      sign_in(user, nil)
    end

    it "with logged in user, returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    describe "with no user is logged in," do

      before do
        sign_out(user)
      end

      it "returns http redirect" do
        get :new
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  describe "when GET #create" do

    before do
      sign_in(user, nil)
    end

    it "with logged in user and good params, returns http redirect" do
      post :create, 
            service: {
              title: 'my awesome service',
              description: 'my super description',
              price: '9.9',
              category_id: agriculture.id
            } 
      expect(flash[:notice]).to match('Prestation crée avec succès')
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(business_services_path)
    end

    it "with logged in user and bad params, returns http unprocessable_entity" do
      post :create, service: { title: nil, description: nil, price: nil, category_id: nil } 
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:new)
    end

    describe "with no user is logged in," do

      before do
        sign_out(user)
      end

      it "returns http redirect" do
        post :create, 
            service: {
              title: 'my awesome service',
              description: 'my super description',
              price: '9.9',
              category_id: agriculture.id
            } 
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  describe "when GET #show" do

    before do
      sign_in(user, nil)
    end

    it "with authorized logged in user, returns http success" do
      get :show, id: service.id
      expect(response).to have_http_status(:success)
    end

    it "with unauthorized logged in user, returns http unauthorized" do
      Service.find(service.id).update_attributes(user_id: nil)
      get :show, id: service.id
      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to eq "Unauthorized"
    end

    describe "with no user is logged in," do

      before do
        sign_out(user)
      end

      it "returns http redirect" do
        get :show, id: service.id
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "when GET #edit" do

    before do
      sign_in(user, nil)
    end

    it "with authorized logged in user, returns http success" do
      get :edit, id: service.id
      expect(response).to have_http_status(:success)
    end

    it "with unauthorized logged in user, returns http unauthorized" do
      Service.find(service.id).update_attributes(user_id: nil)
      get :edit, id: service.id
      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to eq "Unauthorized"
    end

    describe "with no user is logged in," do

      before do
        sign_out(user)
      end

      it "returns http redirect" do
        get :edit, id: service.id
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end
