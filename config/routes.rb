Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  namespace :api, defaults: { format: 'json' } do # /api/data
    get '/index', to: 'cultures#index'
    root 'cultures#index'
    resources :cultures, :locations, only: [:index, :show, :update]
    resources :cultures do 
      resources :locations, only: [:create]
    end
    resources :culture_drafts, only: [:index, :create, :destroy, :update]
    resources  :sessions, only: [:create]
    resources :registrations, only: [:create]
    delete :logout, to: "sessions#logout"
    get :logged_in, to: "sessions#logged_in"
    get :admin, to: "sessions#admin"

  end
  
  # get '*path', to: "static_pages#fallback_index_html", constraints: ->(request) do
  #   !request.xhr? && request.format.html?
  # end
end
