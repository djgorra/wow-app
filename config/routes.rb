Rails.application.routes.draw do

  root to: "pages#home"

  scope :api, defaults: { format: :json } do
    devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
    # devise_for :users, controllers: { sessions: :sessions },
    #                    path_names: { sign_in: :login }

    resource :user, only: [:show, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
