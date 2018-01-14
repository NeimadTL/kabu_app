class CommentsController < ApplicationController


  before_action :authenticate_user!
  before_action :require_to_be_customer


  def create
    @service = Service.find(params[:service_id])
    @comment = @service.comments.create(comment_params.merge(user: current_user))

    if @comment.valid?
      flash[:notice] = "Commentaire ajouté"
    else
      flash[:alert] = @comment.errors.full_messages
    end

    redirect_to service_path(@service)
  end


  private

    def comment_params
      params.require(:comment).permit(:score, :content)
    end

    def require_to_be_customer
      if current_user && current_user.for_business
        render text: "Unauthorized", status: :unauthorized
      end
    end


end
