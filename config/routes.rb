Rails.application.routes.draw do
  
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :users, only:[:show]
      resources :companies
      resources :workflows
      resources :access_rights
      resources :timelines
      resources :recipients
      resources :operators
      resources :tags
      resources :surveys
      resources :menus
      resources :campaigns
    end
  end
  
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
