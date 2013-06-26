Colchonet::Application.routes.draw do

  LOCALES = /en|pt\-BR/
  scope "(:locale)", :locale => LOCALES do

    resources :rooms do
      resources :reviews, :only => [:create, :update], :module => :rooms
    end

    resources :users

    resource :confirmation, :only => [:show]

    resource :user_sessions, :only => [:create, :new, :destroy]
  end

  root :to => "home#index"
  match '/:locale' => 'home#index', :locale => LOCALES
end
