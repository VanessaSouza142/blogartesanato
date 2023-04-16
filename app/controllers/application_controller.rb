class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    helper_method :current_artisan, :logged_in?

    def current_artisan
    @current_artisan ||= Artisan.find(session[:artisan_id]) if session[:artisan_id]
    end

    def logged_in?
    !!current_artisan
    end

    def require_user
        if !logged_in?
            flash[:danger] = "Você deve estar logado para realizar essa ação!"
            redirect_to root_path
        end
    end
end
