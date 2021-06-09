Rails.application.routes.draw do
  
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth',
      controllers: {
        sessions: 'api/v1/devise_token_auth/sessions'
      }

      resources :users, only:[:show]
      resources :companies do
        collection do 
          get :names
        end
        resources :tags do
          collection do 
            get :names
          end
        end
        member do
          get :setting
          get :plans
          get :current_plan
        end
      end
      
      namespace :workflows do
        resources :depositories
      end

      namespace :campaigns do
        resources :depositories
      end

      namespace :platforms do
        resources :recipients do
          collection do
            put :statuses
            put :update_tags
            get :tags
            get :keywords
          end
        end
        resources :operators
      end

      resources :access_rights
      resources :timelines
      resources :surveys
      resources :menus
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
