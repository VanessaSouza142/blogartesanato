Rails.application.routes.draw do
root "pages#home"
get 'pages#home', to: 'pages#home'

resources :handcrafts

get '/signup', to: 'artisans#new'
resources :artisans, except: [:new]

end
