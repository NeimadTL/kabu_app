require 'rails_helper'

RSpec.describe Business::ServicesController, type: :controller do

  let(:user) {
    User.create!(firstname: "John", lastname: "Doe",
      address: "88 Colin P Kelly Jr St San Francisco, CA 94107. United States",
      phonenumber: "+1 (877) 448-4820",
      email: "something@gmail.com", password: "12345678", password_confirmation: "12345678",
      for_business: true)
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
      created_serivce = Service.last
      expect(created_serivce.title).to eq 'my awesome service'
      expect(created_serivce.description).to eq 'my super description'
      expect(created_serivce.price).to be == 9.9
      expect(created_serivce.category_id).to be == agriculture.id
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


  describe "when GET #show" do

    before do
      sign_in(user, nil)
    end

    it "with authorized logged in user, returns http success" do
      get :show, id: service.id
      expect(response).to have_http_status(:success)
    end

    it "with unauthorized logged in user, returns http unauthorized" do
      User.find(user.id).update_attributes(for_business: false)
      get :show, id: service.id
      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to eq "Unauthorized"
    end

    describe "with no user logged in," do

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
      User.find(user.id).update_attributes(for_business: false)
      get :edit, id: service.id
      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to eq "Unauthorized"
    end

    describe "with no user logged in," do

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


  describe "when PUT #update" do

    before do
      sign_in(user, nil)
    end

    it "with authorized logged in user, returns http redirect" do
      put :update,
          id: service.id,
          service: {
            title: 'my awesome service',
            description: 'my super description',
            price: '100',
          }
      updated_service = Service.find(service.id)
      expect(updated_service.title).to eq 'my awesome service'
      expect(updated_service.description).to eq 'my super description'
      expect(updated_service.price).to be == 100.0
      expect(flash[:notice]).to match('Prestation modifiée avec succès')
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(business_services_path)
    end

    it "with unauthorized logged in user, returns http unauthorized" do
      User.find(user.id).update_attributes(for_business: false)
      put :update,
          id: service.id,
          service: {
            title: 'my awesome service',
            description: 'my super description',
            price: '100',
          }
      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to eq "Unauthorized"
    end

    describe "with no user logged in," do

      before do
        sign_out(user)
      end

      it "returns http redirect" do
        put :update,
            id: service.id,
            service: {
            title: 'my awesome service',
            description: 'my super description',
            price: '100',
          }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "when DELETE #destroy" do

    before do
      sign_in(user, nil)
    end

    it "with authorized logged in user, returns http redirect" do
      delete :destroy, id: service.id
      expect(flash[:notice]).to match('Prestation supprimée avec succès')
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(business_services_path)
    end

    it "with unauthorized logged in user, returns http unauthorized" do
      User.find(user.id).update_attributes(for_business: false)
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

end
