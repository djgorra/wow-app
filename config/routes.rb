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


  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
