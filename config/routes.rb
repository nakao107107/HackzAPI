Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :meetings, only: [:index, :show, :create] do
    resources :attendees, only: [:index]
    resource :room, only: [:create, :show]
    post 'attend' => 'meetings#attend'
  end
  resources :users do
    collection do
      post 'login' => 'users#login'
      post 'signup' => 'users#signup'
      resource :profile, only: [:show, :update]
    end
  end
  get '/files/presigned-url' => 'files#presigned_url'
end
