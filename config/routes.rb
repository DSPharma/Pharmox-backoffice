Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :entries
  resources :pharmacies do
    collection { post :import }
  end
  resources :campaigns do
    collection { post :import }
  end
  resources :laboratories

  post 'campaigns/product' => 'campaigns#product'
  # post 'challenges/product' => 'challenges#product'

  namespace :api do
    namespace :v1 do
      resources :pharmacies
      devise_scope :user do
        post "/sign_in", :to => 'sessions#create'
        post "/sign_up", :to => 'registrations#create'
        delete "/sign_out", :to => 'sessions#destroy'
      end
    end
  end

  # resources :dashboards
  get 'dashboards/campaigns/current' =>'dashboards#campaigns_current'
  get 'dashboards/campaigns/past' =>'dashboards#campaigns_past'
  get 'dashboards/campaigns/futur' =>'dashboards#campaigns_futur'
  # get 'dashboards/challenges/current' =>'dashboards#challenges_current'
  # get 'dashboards/challenges/past' =>'dashboards#challenges_past'
  # get 'dashboards/challenges/futur' =>'dashboards#challenges_futur'

  authenticated do
      root to: "dashboards#campaigns_current", as: :authenticated_root
  end

  devise_for :users, controllers: { registrations: "users/registrations" }

  root 'pages#home'
end
