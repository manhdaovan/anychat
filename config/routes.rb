Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :home, only: [:index] do
    collection do
      post :login
      put :logout
    end
  end
end
