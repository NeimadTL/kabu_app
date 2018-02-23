require 'rails_helper'

RSpec.describe ServicesController, type: :controller do


  let(:user) {
    User.create!(firstname: "John", lastname: "Doe",
      address: "88 Colin P Kelly Jr St San Francisco, CA 94107. United States",
      phonenumber: "+1 (877) 448-4820",
      email: "something@gmail.com", password: "12345678", password_confirmation: "12345678",
      for_business: false)
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


  describe "when GET #index" do

    before do
      sign_in(user, nil)
    end

    it "with authorised logged in user, returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "with unauthorised logged in user, returns http unauthorized" do
      sign_out(user)
      User.find(user.id).update_attributes(for_business: true)
      sign_in(user, nil)
      get :index
      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to eq "Unauthorized"
    end

    it "with no logged in user, returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end


  describe "when GET #show" do

    before do
      sign_in(user, nil)
    end

    it "with authorised logged in user, returns http success" do
      get :show, id: service.id
      expect(response).to have_http_status(:success)
    end


    it "with unauthorised logged in user, returns http unauthorized" do
      sign_out(user)
      User.find(user.id).update_attributes(for_business: true)
      sign_in(user, nil)
      get :show, id: service.id
      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to eq "Unauthorized"
    end

    it "with no logged in user, returns http success" do
      get :show, id: service.id
      expect(response).to have_http_status(:success)
    end
  end

end
