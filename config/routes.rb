Rails.application.routes.draw do
  resource :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: "pages#home"
  scope :api, defaults: { } do
    devise_for :users,
             controllers: {
                 sessions: 'login/sessions',
                 registrations: 'login/registrations'
             }
    # devise_for :users, controllers: { sessions: :sessions },
    #                    path_names: { sign_in: :login }
    get "characters", to: 'characters#index'
    get "characters/:id", to: 'characters#show'
    post "characters", to: 'characters#create'
    put "characters/:id", to: 'characters#update'
    delete "characters/:id", to: 'characters#destroy'
    get "datafile", to: 'data#datafile'
    devise_scope :user do
      post "users/uuid", to: "login/sessions#uuid"
    end
  end
  get "oauth2/login", to: 'oauth#login'
  get "oauth2/callback", to: 'oauth#callback'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
