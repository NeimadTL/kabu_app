class ServicesController < ApplicationController
  

  before_action :set_service, only: [:show]
  before_action :require_to_be_customer_or_visitor


  def index
    @services = Service.all
  end


  def show
    @comment = Comment.new
  end


  private
    
    def set_service
      @service = Service.find(params[:id])
    end

    def service_params
      params.require(:service).permit(:title, :description, :price)
    end

    def require_to_be_customer_or_visitor
      if current_user && current_user.for_business
        render text: "Unauthorized", status: :unauthorized
      end
    end
end
