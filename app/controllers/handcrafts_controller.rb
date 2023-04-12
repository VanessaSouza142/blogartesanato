class HandcraftsController < ApplicationController
    def index
        @handcrafts = Handcraft.all
    end
end