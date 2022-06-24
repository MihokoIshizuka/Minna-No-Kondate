Rails.application.routes.draw do
  devise_for :members, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:passwords, :registrations], controllers: {
    sessions: "admin/sessions"
  }


  devise_scope :member do
    post 'members/guest_sign_in' => 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root to: "homes#top"
    get '/about' => "homes#about"
    get "search" => "searches#search"


    resources :members, except: [:destroy] do
      get '/quit' => "members#quit"
      patch '/out' => "members#out"
      get '/favorites' => "members#favorites"
      resource :relationships, only: [:create, :destroy]
        get 'followings' => "relationships#followings", as: 'followings'
        get 'followers' => "relationships#followers", as: 'followers'
      resource :contacts, only: [:create, :show]
      resources :notifications, only: :index
      delete 'notifications/all_destroy' => "notifications#all_destroy"


    end

    resources :menus do
      resources :menu_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    resources :groups do
      get 'join' => "groups#join"
      delete 'all_destroy' => "groups#all_destroy"
      resources :chats, only: [:index, :create, :destroy]
    end


  end

  namespace :admin do
    get 'members/contacts' => "contacts#index"
    get "search" => "searches#search"

    resources :members, only: [:index, :show, :edit, :update, :destroy] do
      resource :contacts, only: [:show, :create]
      resources :contacts, only: [:destroy]
    end
    resources :tags, only: [:index, :create, :update, :edit, :destroy]
    resources :groups, only: [:index, :show, :edit, :update] do
      delete '/all_destroy' => "groups#all_destroy"
      resources :chats, only: [:index, :create, :destroy]
    end
    resources :menus, only: [:index, :show, :edit, :update, :destroy] do
      resources :menu_comments, only: [:create, :destroy]
    end

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
