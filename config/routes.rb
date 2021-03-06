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
  post 'user/preference/' => 'users#set_preference', as: :user_preference

  resources :events, only: [:create,:new,:destroy,:edit,:update]
  get 'events/check/:id' => 'events#check_event', as: :check_event
  # patch 'events/:id(.:format)' => "events#update"

  resources :sessions, only: [:create, :new] do
    delete :destroy, on: :collection
  end

  get 'auth/'  => 'callbacks#redirect', as: :sign_in_with_google
  get 'auth/callback' => 'callbacks#google', as: :callback
  # get 'auth/redirect'  => 'callbacks#redirect'
  # get 'auth/failure' => 'callbacks#failure'
  get 'auth/signout' => 'callbacks#signout_google', as: :google_signout

  get 'token/:key' => 'tokens#show', as: :token
  get 'forget_password' => 'tokens#forget_password', as: :forget_psasword
  post 'forget_password' => 'tokens#forget_password_respond'

  get 'info' => 'info#show', as: :info
  get 'info/:id' => 'info#edit', as: :info_edit
  post 'info/update/:id' => 'info#update', as: :info_update
  post 'info/create' => 'info#create', as: :info_create
  delete 'info/:id' => 'info#destroy', as: :info_destroy

  resources :tasks, only: [:create,:destroy,:edit,:update]
  resources :schedules,except:[:show], shallow:true do
  end
  resources :diaries, only: [:create,:destroy,:index]
  
  root 'welcome#home'
  get 'about' => 'welcome#about', as: :about
  get 'terms' => 'welcome#terms', as: :terms

  get 'schedule/' => 'schedules#show', as: :schedule_show
  post 'schedule/update' => 'schedules#update', as: :schedule_update
  get 'schedule/clear' => 'schedules#clear', as: :schedule_clear

  get 'calendar/' => 'calendar#show', as: :calendar
  get 'calendar/Daily' => 'calendar#calendar', as: :calendar_show
  get 'calendar/Weekly' => 'calendar#calendar_week', as: :calendar_week_show
  get 'calendar/Mothly' => 'calendar#calendar_month', as: :calendar_month_show
  get 'calendar/3Days' => 'calendar#calendar_3days', as: :calendar_3days_show
  get 'calendar/run_schedule' => 'events#run_schedule', as: :run_schedule
  get 'calendar/filtered' => 'calendar#filter', as: :calendar_filter

end
