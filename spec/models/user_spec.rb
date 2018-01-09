require 'rails_helper'

RSpec.describe User, type: :model do
  
  it { should respond_to(:favorites) }
  it { should respond_to(:services) }
  it { should respond_to(:add_as_favorite) }
  it { should respond_to(:delete_as_favorite) }
  it { should respond_to(:has_favorite?) }


  
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


  describe "when user adds service as favorite" do
    subject { user }

    before do
      user.add_as_favorite(service)
    end

    it { should be_has_favorite(service) }
    it { expect(subject.services).to include(service) }

    describe "and when user deletes service as favorite" do
      before do
        user.delete_as_favorite(service)
      end

      it { should_not be_has_favorite(service) }
      it { expect(subject.services).to_not include(service) }
    end
  end  
end
