class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  
  before_filter :load_all_categories


  # redirect to right the url according to user role
  def after_sign_in_path_for(resource_or_scope)
    if current_user 
      if current_user.for_business?
        business_services_url
      else
        favorites_url
      end
    end
  end


  # loading all categories so they are available everywhere
  def load_all_categories
    @categories = Category.all
  end


end
