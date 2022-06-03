Rails.application.routes.draw do
  devise_for :members, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:passwords, :registrations], controllers: {
    sessions: "admin/sessions"
  }

scope module: :member do
  root to: "homes#top"

end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
