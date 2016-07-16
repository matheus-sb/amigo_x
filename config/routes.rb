Rails.application.routes.draw do
  devise_for :users

  resources :groups do 
    member do
      get 'raffle'
      get 'secret_friend'
      get 'messages'
    end
    resources :participants, only: [:create, :destroy, :show]
  end

  get '/participants/:id/confirm', :to => 'participants#confirm', :as => :confirm_participant
    
  authenticated :user do
    root 'groups#index', as: "authenticated_root"
  end

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
