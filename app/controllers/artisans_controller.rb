class ArtisansController < ApplicationController
    before_action :set_artisan, only: [:show, :edit, :update, :destroy]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    def index
        @artisans = Artisan.paginate(page: params[:page], per_page: 5)
    end

    def new
        @artisan = Artisan.new
    end
  
    def create
        @artisan = Artisan.new(artisan_params)
        if @artisan.save
          session[:artisan_id] = @artisan.id  
          flash[:success] = "Bem-vindo #{@artisan.name} ao seu blog de artesanato em geral"
          redirect_to artisan_path(@artisan)
        else
          render 'new', status: :unprocessable_entity
        end
    end

    def show
        @artisan_handcrafts = @artisan.handcrafts.paginate(page: params[:page], per_page: 5)
    end

    def edit

    end
      
    def update
        if @artisan.update(artisan_params)
          flash[:success] = "Sua conta foi atualizada com sucesso!"
          redirect_to @artisan
        else
          render 'edit', status: :unprocessable_entity
        end  
    end

    def destroy
        @artisan.destroy
        flash[:danger] = "O artesão e todos os artesanatos associados a ele foram deletados!"
        redirect_to artisans_path
    end

    private
  
    def artisan_params
        params.require(:artisan).permit(:name, :email, :password, :password_confirmation)
    end

    def set_artisan
        @artisan = Artisan.find(params[:id])
    end

    def require_same_user
        if current_artisan != @artisan
          flash[:danger] = "Você só pode editar ou deletar sua própria conta"
          redirect_to artisans_path
        end  
    end
end