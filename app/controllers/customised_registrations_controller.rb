class CustomisedRegistrationsController < Devise::RegistrationsController

  def create
    super
  end

  private

    def sign_up_params
      params.require(resource_name).permit(:firstname, :lastname, :address, :phonenumber,
        :email, :password, :password_confirmation, :for_business)
    end
end
