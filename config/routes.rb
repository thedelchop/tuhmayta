Tuhmayta::Application.routes.draw do

  get "pages/home"

  devise_for :users do
    resources :tasks
  end

  root :to => "pages#home"
end
