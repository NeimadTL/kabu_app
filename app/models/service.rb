class Service < ActiveRecord::Base

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :category

  has_many :favorites
  has_many :users, :through => :favorites

end
