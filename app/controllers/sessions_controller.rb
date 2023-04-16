class SessionsController < ApplicationController
  
    def new
    # will simply render the form
    end
  
    def create
    # will create the session and move the user to logged in state
        artisan = Artisan.find_by(email: params[:session][:email].downcase)
        if artisan && artisan.authenticate(params[:session][:password])
            session[:artisan_id] = artisan.id
            flash[:success] = "Você fez login com sucesso!"
            redirect_to artisan
        else
            flash.now[:danger] = "Sua informação de login está errada!"
            render 'new', status: :unprocessable_entity
        end
    end
  
    def destroy
    # will end the session or simulate logged out state
        session[:artisan_id] = nil
        flash[:success] = "Você fez logout!"
        redirect_to root_path
    end
  
  end 