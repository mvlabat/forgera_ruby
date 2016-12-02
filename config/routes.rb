Rails.application.routes.draw do
  resources :mods
  get '/update', to: 'mods#check_updates'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
