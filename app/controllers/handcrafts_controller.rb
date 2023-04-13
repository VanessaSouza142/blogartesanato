class HandcraftsController < ApplicationController
    def index
        @handcrafts = Handcraft.all
    end

    def show
        @handcraft = Handcraft.find(params[:id])
    end
end