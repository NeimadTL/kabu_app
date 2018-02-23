class User < ActiveRecord::Base


  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :address, presence: true
  validates :phonenumber, presence: true, uniqueness: true


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :favorites
  has_many :services, :through => :favorites
  has_many :comments, :dependent => :destroy
  has_many :services_for_business, foreign_key: "user_id", class_name: "Service"


  # adds service to favorite list
  def add_as_favorite(service)
    favorites.create(service_id: service.id)
  end


  # deletes service to favorite list
  def delete_as_favorite(service)
    favorites.find_by(service_id: service.id).destroy
  end


  # returns true if user has a service as a favorite
  def has_favorite?(service)
    services.include?(service)
  end

end
