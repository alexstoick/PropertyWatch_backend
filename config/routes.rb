PropertyWatchBackend::Application.routes.draw do

  resources :zone, only: :show
  resources :user , only: [:show,:create,:update,:destroy]

  match "zone/:id/properties" , to: "zone#showProperties" , via: :get

end
