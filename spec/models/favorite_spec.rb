require 'rails_helper'

RSpec.describe Favorite, type: :model do

  let(:user) {
    User.create!(firstname: "John", lastname: "Doe",
      address: "88 Colin P Kelly Jr St San Francisco, CA 94107. United States",
      phonenumber: "+1 (877) 448-4820",
      email: "something@gmail.com", password: "12345678", password_confirmation: "12345678")
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
  let(:favorite) { user.favorites.build(service_id: service.id) }


  subject { favorite }

  it { should be_valid }
  it { should respond_to(:user) }
  it { should respond_to(:service) }


  describe "when service id is not present" do
    before { favorite.service_id = nil }
    it { should_not be_valid }
  end

  describe "when user id is not present" do
    before { favorite.user_id = nil }
    it { should_not be_valid }
  end

end
