Rails.application.routes.draw do
root "pages#home"
get 'pages#home', to: 'pages#home'

resources :handcrafts

get '/signup', to: 'artisans#new'
resources :artisans, except: [:new]

get '/login', to: 'sessions#new'
post '/login', to: "sessions#create"
delete '/logout', to: "sessions#destroy"

resources :materials, except: [:destroy]

end
