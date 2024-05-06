Rails.application.routes.draw do
  resource :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: "pages#home"
  get "privacy_policy", to: 'pages#privacy_policy'
  get "account_deletion", to: 'pages#account_deletion'
  get "tutorial", to: 'pages#tutorial'
  scope :api, defaults: { } do
    devise_for :users,
             controllers: {
                 sessions: 'login/sessions',
                 registrations: 'login/registrations'
             }
    # devise_for :users, controllers: { sessions: :sessions },
    #                    path_names: { sign_in: :login }



    # characters
    resource :characters
    get "characters", to: 'characters#index'
    get "characters/:id", to: 'characters#show'
    post "characters", to: 'characters#create'
    put "characters/:id", to: 'characters#update'
    delete "characters/:id", to: 'characters#destroy'
    post "characters/:id/items", to: 'characters#add_items'
    get "characters/:id/drops", to: 'characters#show_drops'
    post "characters/discord_create" => "characters#discord_create"

    # data
    get "datafile", to: 'data#datafile'

    # friends
    get "friendlist", to: 'friends#index'
    post "friendlist", to: 'friends#create'
    delete "friendlist/:id", to: 'friends#destroy'

    #teams
    get "teams", to: 'teams#index'
    get "teams/:id", to: 'teams#show'
    post "teams", to: 'teams#create'
    put "teams/:id", to: 'teams#update'
    delete "teams/:id", to: 'teams#destroy'
    post "teams/:id/characters", to: 'teams#add_characters'
    post "teams/:invite_code/invite", to: 'teams#invite'
    delete "teams/:id/characters", to: 'teams#remove_characters'

    #runs 
    get "/teams/:team_id/runs", to: 'runs#index'
    get "/teams/:team_id/runs/:id", to: 'runs#show'
    post "/teams/:team_id/runs", to: 'runs#create'
    get "/teams/:team_id/runs/:id/summary", to: 'runs#summary'
    post "/teams/:team_id/runs/:id/mark_completed", to: 'runs#mark_completed'
    get "/teams/:team_id/completed", to: 'runs#completed_index'

    #battles
    post "battles", to: 'battles#create'
    get "battles/:id", to: 'battles#show'
    post "battles/:id/create_drop", to: 'battles#create_drop'

    #raids
    get "raids/:id/items", to: 'raids#items'
    get "raids", to: 'raids#index'

    #drops
    get "/battles/:battle_id/drops/:id", to: 'drops#show'
    post "/battles/:battle_id/drops", to: 'drops#create'
    post "/battles/:battle_id/drops/:id", to: 'drops#update'

    #buffs
    get "buffs", to: 'data#buffs'

    delete "users/:id", to: 'users#delete'

    devise_scope :user do
      post "users/uuid", to: "login/sessions#uuid"
    end
  end
  get "oauth2/login", to: 'oauth#login'
  get "oauth2/callback", to: 'oauth#callback'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
