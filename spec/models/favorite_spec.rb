require 'rails_helper'

RSpec.describe Favorite, type: :model do
  
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
  let(:favorite) { user.favorites.build(service_id: service.id) }


  subject { favorite }

  it { should be_valid }
  it { should respond_to(:user) }
  it { should respond_to(:service) }
  
end