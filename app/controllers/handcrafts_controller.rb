class HandcraftsController < ApplicationController
    before_action :set_handcraft, only: [:show, :edit, :update]

    def index
        @handcrafts = Handcraft.all
    end

    def show
        
    end

    def new
        @handcraft = Handcraft.new
    end

    def create
        @handcraft = Handcraft.new(handcraft_params)
        @handcraft.artisan = Artisan.first
        if @handcraft.save
            flash[:success] = "Handcraft was created successfully!"
            redirect_to handcraft_path(@handcraft)
        else
            render 'new', status: :unprocessable_entity
        end
    end

    def edit
        
    end
      
    def update
        if @handcraft.update(handcraft_params)
            flash[:success] = "Handcraft was updated successfully!"
            redirect_to handcraft_path(@handcraft)
        else
          render 'edit'
        end
    end

      def destroy
        Handcraft.find(params[:id]).destroy
        flash[:success] = "Handcraft deleted successfully"
        redirect_to handcrafts_path
      end

    private

        def set_handcraft
            @handcraft = Handcraft.find(params[:id])
        end

        def handcraft_params
            params.require(:handcraft).permit(:name, :description)
        end
end