Tuhmayta::Application.routes.draw do

  get "pomodoro/create"

  get "pomodoro/index"

  get "pages/home"

  devise_for :users do
    resources :tasks
    
    resources :lists do
      
      member do
        post :sort
        post :add
      end
    end
  end

  devise_scope :user do
    root :to => "devise/sessions#new"
  end

end
