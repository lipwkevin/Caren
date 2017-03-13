Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:create, :new]
  delete 'user'=> 'users#destroy', as: :user_delete
  get 'user/' => 'users#show', as: :user_show
  get 'user/edit' => 'users#edit', as: :user_edit
  post 'user/edit' => 'users#update'
  get 'user/edit/password' => 'users#edit_password', as: :user_password
  post 'user/edit/password' => 'users#update_password'
  post 'user/reset/' => 'users#reset_password_respond', as: :reset_password

  resources :events, only: [:create,:new,:destroy,:edit,:update]
  get 'events/check/:id' => 'events#check_event', as: :check_event
  # patch 'events/:id(.:format)' => "events#update"

  resources :sessions, only: [:create, :new] do
    delete :destroy, on: :collection
  end

  get 'auth/'  => 'callbacks#redirect', as: :sign_in_with_google
  get 'auth/callback' => 'callbacks#google', as: :callback


  get 'token/:key' => 'tokens#show', as: :token
  get 'forget_password' => 'tokens#forget_password', as: :forget_psasword
  post 'forget_password' => 'tokens#forget_password_respond'


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
