class CommentsController < ApplicationController


  before_action :authenticate_user!


  def create
    @service = Service.find(params[:service_id])
    @comment = @service.comments.create(comment_params.merge(user: current_user))

    if @comment.valid?
      flash[:success] = "Commentaire ajouté"
    else
      flash[:alert] = "Erreur survenue"
    end

    redirect_to service_path(@service)
  end


  private

    def comment_params
      params.require(:comment).permit(:score, :content)
    end


end
