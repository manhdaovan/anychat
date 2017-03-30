# == Route Map
#
#            Prefix Verb   URI Pattern                   Controller#Action
#  login_home_index POST   /home/login(.:format)         home#login
# logout_home_index DELETE /home/logout(.:format)        home#logout
#        home_index GET    /home(.:format)               home#index
#             rooms GET    /rooms(.:format)              rooms#index
#          messages POST   /messages(.:format)           messages#create
#                   GET    /rooms/:username(.:format)    rooms#index {:username=>/[a-zA-Z0-9]+/i}
#         edit_user GET    /users/:id/edit(.:format)     users#edit
#              user PATCH  /users/:id(.:format)          users#update
#                   PUT    /users/:id(.:format)          users#update
#      active_email GET    /users/active_email(.:format) users#active_email
#      users_online POST   /users/online(.:format)       users#check_online
#             users POST   /users(.:format)              users#index
#              root GET    /                             home#index
#

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :home, only: [:index] do
    collection do
      post :login
      delete :logout
    end
  end

  resources :rooms, only: [:index]
  resources :messages, only: [:create]
  get 'rooms/:username', to: 'rooms#index', constraints: {username: /[a-zA-Z0-9]+/i}
  resources :users, only: [:edit, :update]
  get 'users/active_email', to: 'users#active_email', as: :active_email

  post 'users/online', to: 'users#check_online'
  post 'users', to: 'users#index'

  root to: 'home#index'
end
