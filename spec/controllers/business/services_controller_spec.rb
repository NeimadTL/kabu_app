require 'rails_helper'

RSpec.describe Business::ServicesController, type: :controller do

  let(:user) { 
    User.create!(email: "something@gmail.com", password: "12345678", password_confirmation: "12345678")
  }
  let(:agriculture) { Category.create!(name: 'AGRICULTURE') }


  describe "when GET #index" do

    before do
      sign_in(user, nil)
    end

    it "with logged in user, returns http success" do
      get :index
      expect(response).to have_http_status(:success)
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


  describe "when GET #new" do

    before do
      sign_in(user, nil)
    end

    it "with logged in user, returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    describe "with no user logged in," do

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

    describe "with no user logged in," do

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

end
