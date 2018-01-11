class FavoritesController < ApplicationController


  before_action :authenticate_user!


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
end
