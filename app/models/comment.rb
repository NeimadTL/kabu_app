class Comment < ActiveRecord::Base

  validates :score, presence: true, numericality: { only_integer: true }, inclusion: { in: 1..5 }
  validates :content, presence: true

  belongs_to :user
  belongs_to :service
end
