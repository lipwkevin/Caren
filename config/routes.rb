Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:create, :new,:destroy]

  resources :events, only: [:create,:new,:destroy,:edit,:update]
  resources :sessions, only: [:create, :new] do
    delete :destroy, on: :collection
  end

  resources :schedules,except:[:show], shallow:true do
    resources :tasks, only: [:create,:destroy,:edit]
  end
  root 'welcome#home'
  match 'users/' => 'users#show', :via => :get, as: :user_show
  match 'schedule/' => 'schedules#show', :via => :get, as: :schedule_show
  match 'calendar/' => 'calendar#calendar', :via => :get, as: :calendar_show

end
