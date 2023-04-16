class PagesController < ApplicationController
    def home
        redirect_to handcrafts_path if logged_in?
    end

end
