Tuhmayta::Application.routes.draw do

  get "pomodoro/create"

  get "pomodoro/index"

  get "pages/home"

  devise_for :users do
    resources :tasks
  end

  root :to => "pages#home"
end
