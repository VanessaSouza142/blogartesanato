class ArtisansController < ApplicationController
    
    def index
        @artisans = Artisan.paginate(page: params[:page], per_page: 5)
      end

    def new
      @artisan = Artisan.new
    end
  
    def create
        @artisan = Artisan.new(artisan_params)
        if @artisan.save
          flash[:success] = "Bem-vindo #{@artisan.name} ao seu blog de artesanato em geral"
          redirect_to artisan_path(@artisan)
        else
          render 'new', status: :unprocessable_entity
        end
    end

    def show
        @artisan = Artisan.find(params[:id])
        @artisan_handcrafts = @artisan.handcrafts.paginate(page: params[:page], per_page: 5)
    end

    def edit
        @artisan = Artisan.find(params[:id])
      end
      
      def update
        @artisan = Artisan.find(params[:id])
        if @artisan.update(artisan_params)
          flash[:success] = "Sua conta foi atualizada com sucesso"
          redirect_to @artisan
        else
          render 'edit', status: :unprocessable_entity
        end  
      end

      def destroy
        @artisan = Artisan.find(params[:id])
        @artisan.destroy
        flash[:danger] = "O artesão e todos os artesanatos associados a ele foram deletados"
        redirect_to artisans_path
      end

    private
  
    def artisan_params
        params.require(:artisan).permit(:name, :email, :password, :password_confirmation)
    end
end