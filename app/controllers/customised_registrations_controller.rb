class CustomisedRegistrationsController < Devise::RegistrationsController

  def create
    super
  end
 
  private
 
    def sign_up_params
      params.require(resource_name).permit(:email, :password, :password_confirmation, :for_business)
    end
end
