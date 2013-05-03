Nigel::Application.routes.draw do

  root :to => 'dashboard#homepage'

 match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

  resources :tasks
  
end
