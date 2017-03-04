Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:create, :new]
  get 'user/' => 'users#show', as: :user_show
  get 'user/edit' => 'users#edit', as: :user_edit
  post 'user/edit' => 'users#update', as: :user_update
  get 'user/edit/password' => 'users#edit_password', as: :user_edit_password
  post 'user/edit/password' => 'users#update_password', as: :user_update_password

  resources :events, only: [:create,:new,:destroy,:edit,:update]
  get 'events/check/:id' => 'events#check_event', as: :check_event

  resources :sessions, only: [:create, :new] do
    delete :destroy, on: :collection
  end

  resources :schedules,except:[:show], shallow:true do
    resources :tasks, only: [:create,:destroy,:edit]
  end
  root 'welcome#home'
  get 'about' => 'welcome#about', as: :about
  get 'schedule/' => 'schedules#show', as: :schedule_show
  # get 'calendar/' => 'calendar#calendar', as: :calendar_show
  get 'calendar/' => 'calendar#calendar', as: :calendar_show
  get 'calendar/run_schedule' => 'events#run_schedule', as: :run_schedule
end
