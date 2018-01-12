class Business::ServicesController < ApplicationController


  before_action :authenticate_user!
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  before_action :require_authorized_for_current_service, only: [:show, :edit, :update, :destroy]


  def index
    @services = current_user.services_for_business
  end


  def new
    @service = Service.new
    @categories = Category.all
  end


  def create
    @service = current_user.services_for_business.create(service_params.merge(user: current_user))
    
    if @service.valid?
      flash[:notice] = 'Prestation crée avec succès'
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  def show
    
  end


  def edit
    @categories = Category.all
  end


  def update
    @service.update_attributes(service_params)

    if @service.valid?
      flash[:notice] = 'Prestation modifiée avec succès'
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @service.destroy
    flash[:notice] = 'Prestation supprimée avec succès'
    redirect_to root_path
  end


  private 

    def service_params
      params.require(:service).permit(:title, :description, :price, :category_id)
    end

    def require_authorized_for_current_service
      if set_service.user != current_user
        render text: "Unauthorized", status: :unauthorized
      end
    end

    def set_service
      @service = Service.find(params[:id])
    end
end
