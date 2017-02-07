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
  get 'users/' => 'users#show', as: :user_show
  get 'schedule/' => 'schedules#show', as: :schedule_show
  get 'calendar/' => 'calendar#calendar', as: :calendar_show
  get 'calendar/run_schedule' => 'calendar#run_schedule', as: :run_schedule
end
