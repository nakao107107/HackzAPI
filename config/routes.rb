Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :meetings, only: [:index, :show, :create] do
    resource :room, only: [:create, :show]
    post 'attend' => 'meetings#attend'
  end
  resources :users do
    collection do
      post 'login' => 'users#login'
      get 'profile' => 'users#profile'
    end
  end
end
