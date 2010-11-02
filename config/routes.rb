require 'lib/root_constraints'

Tuhmayta::Application.routes.draw do

  get "pages/home"

  constraints(RootConstraints) do
     match '/', :controller => "lists", :action => "index"
  end

  root :to => "pages#home"

  devise_for :users do
    resources :tasks
    
    resources :lists do
      
      member do
        post :sort
        post :add
      end
    end
  end
end
