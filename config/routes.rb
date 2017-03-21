# == Route Map
#
#            Prefix Verb URI Pattern            Controller#Action
#  login_home_index POST /home/login(.:format)  home#login
# logout_home_index PUT  /home/logout(.:format) home#logout
#        home_index GET  /home(.:format)        home#index
#              root GET  /                      home#index
#

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :home, only: [:index] do
    collection do
      post :login
      put :logout
    end
  end
  root to: 'home#index'
end
