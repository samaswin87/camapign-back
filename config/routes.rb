Rails.application.routes.draw do
  
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth',
      controllers: {
        sessions: 'api/v1/devise_token_auth/sessions'
      }

      resources :users, only:[:show]
      resources :companies do
        member do 
          get :setting
          get :plans
          get :current_plan
        end
      end
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
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
