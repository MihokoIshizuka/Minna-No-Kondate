Rails.application.routes.draw do
  devise_for :members, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:passwords, :registrations], controllers: {
    sessions: "admin/sessions"
  }

scope module: :public do
  root to: "homes#top"
  get '/about' => "homes#about"
  get '/members/:id/quit' => "members#quit"

  resources :members, except: [:destroy] do
    resource :relationships, only: [:create, :destroy]
      get 'followings' => "relationships#followings", as: 'followings'
      get 'followers' => "relationships#followers", as: 'followers'
  end

  resources :menus do
    resources :menu_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :groups do
    get 'join' => "groups#join"
    delete 'all_destroy' =>"groups#all_destroy"
    resources :chats, only: [:index, :create, :destroy]
  end


end

namespace :admin do

  resources :members, only: [:index, :show, :edit, :update]
  resources :tags, only: [:index, :create, :update, :edit, :destroy]

end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
