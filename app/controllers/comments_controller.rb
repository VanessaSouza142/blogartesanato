class CommentsController < ApplicationController
    before_action :require_user
    
    def create
      @handcraft = Handcraft.find(params[:handcraft_id])
      @comment = @handcraft.comments.build(comment_params)
      @comment.artisan = current_artisan
      if @comment.save
        flash[:success] = "O comentário foi criado com sucesso!"
        redirect_to handcraft_path(@handcraft)
      else
        flash[:danger] = "O comentário não foi criado!"
        redirect_to handcraft_path(@handcraft)
      end
    end
    
    private
    
    def comment_params
      params.require(:comment).permit(:description)
    end
    
  end