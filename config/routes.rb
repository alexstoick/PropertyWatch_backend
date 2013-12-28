PropertyWatchBackend::Application.routes.draw do

  resources :user , :only => [:show,:create,:update]

end
