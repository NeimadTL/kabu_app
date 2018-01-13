class FavoritesController < ApplicationController


  before_action :authenticate_user!
  before_action :require_authorized_for_current_service


  def index
    @favorites = current_user.favorites
  end


  def create
    @service = Service.find(params[:service_id])
    current_user.add_as_favorite(@service)
    redirect_to service_path(@service)
  end


  def destroy
    @service = Favorite.find(params[:id]).service
    current_user.delete_as_favorite(@service)
    redirect_to service_path(@service)
  end


  private

    def require_authorized_for_current_service
      if current_user.for_business
        render text: "Unauthorized", status: :unauthorized
      end
    end
end
