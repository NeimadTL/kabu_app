require 'rails_helper'

RSpec.describe Service, type: :model do
  
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_presence_of :price }
  it { is_expected.to allow_value('0.0').for(:price) }
  it { is_expected.to_not allow_value('-1').for(:price) }
  
end