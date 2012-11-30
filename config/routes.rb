Nigel::Application.routes.draw do
  resources :tasks


  root :to => 'mainframe#homepage'
end
