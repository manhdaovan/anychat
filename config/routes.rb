# == Route Map
#
#            Prefix Verb  URI Pattern                   Controller#Action
#  login_home_index POST  /home/login(.:format)         home#login
# logout_home_index PUT   /home/logout(.:format)        home#logout
#        home_index GET   /home(.:format)               home#index
#             rooms GET   /rooms(.:format)              rooms#index
#          messages POST  /messages(.:format)           messages#create
#                   GET   /messages/:username(.:format) messages#index {:username=>/[a-zA-Z0-9\.@_-]+/i}
#         edit_user GET   /users/:id/edit(.:format)     users#edit
#              user PATCH /users/:id(.:format)          users#update
#                   PUT   /users/:id(.:format)          users#update
#              root GET   /                             home#index
#

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :home, only: [:index] do
    collection do
      post :login
      put :logout
    end
  end

  resources :rooms, only: [:index]
  resources :messages, only: [:create]
  get 'messages/:username', to: 'messages#index', constraints: {username: /[a-zA-Z0-9\.@_-]+/i}
  resources :users, only: [:edit, :update]

  root to: 'home#index'
end
