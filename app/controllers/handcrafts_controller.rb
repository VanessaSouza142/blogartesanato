class HandcraftsController < ApplicationController
    def index
        @handcrafts = Handcraft.all
    end

    def show
        @handcraft = Handcraft.find(params[:id])
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
        @handcraft = Handcraft.find(params[:id])
      end
      
      def update
        @handcraft = Handcraft.find(params[:id])
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
        def handcraft_params
            params.require(:handcraft).permit(:name, :description)
        end
end