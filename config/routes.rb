Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:create, :new]
  resources :sessions, only: [:create, :new] do
    delete :destroy, on: :collection
  end

  root 'welcome#home'
end
