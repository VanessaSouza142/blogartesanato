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
          flash[:success] = "Welcome #{@artisan.name} to My Handcrafts Blog!"
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
          flash[:success] = "Your account was updated successfully"
          redirect_to @artisan
        else
          render 'edit', status: :unprocessable_entity
        end  
      end

    private
  
    def artisan_params
        params.require(:artisan).permit(:name, :email, :password, :password_confirmation)
    end
end