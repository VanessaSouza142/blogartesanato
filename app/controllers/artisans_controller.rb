class ArtisansController < ApplicationController
  
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

    end

    private
  
    def artisan_params
        params.require(:artisan).permit(:name, :email, :password, :password_confirmation)
    end
end