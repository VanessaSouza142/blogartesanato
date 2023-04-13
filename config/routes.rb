Rails.application.routes.draw do
root "pages#home"
get 'pages#home', to: 'pages#home'

get '/handcrafts', to: 'handcrafts#index'
get '/handcrafts/:id', to: 'handcrafts#show', as: 'handcraft'

end
