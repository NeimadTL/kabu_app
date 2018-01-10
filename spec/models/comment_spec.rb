require 'rails_helper'

RSpec.describe Comment, type: :model do

  it { should validate_presence_of :content }
  it { should validate_presence_of :score }
  it { is_expected.to allow_value('1').for(:score) }
  it { is_expected.to allow_value('3').for(:score) }
  it { is_expected.to allow_value('5').for(:score) }
  it { is_expected.to_not allow_value('0').for(:score) }
  it { is_expected.to_not allow_value('6').for(:score) }
  it { is_expected.to_not allow_value('4.5').for(:score) }
  it { is_expected.to_not allow_value('one').for(:score) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:service) }

  
end
