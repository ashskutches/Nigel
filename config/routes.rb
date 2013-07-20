Nigel::Application.routes.draw do

  root :to => 'dashboard#homepage'

 match 'auth/:provider/callback', to: 'sessions#create'
 match 'auth/failure', to: redirect('/')
 match 'signout', to: 'sessions#destroy', as: 'signout'
 match '/user/:user_id/tasks', to: 'tasks#new_tasks', as: 'new_tasks'

  resources :user, :only => [:new, :create] do
    resources :tasks, :only => [:new, :create, :index, :update]
  end
  
end
