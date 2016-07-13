Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'

  # get '/groups/:id/raffle', :to => 'groups#raffle', :as => :raffle_group
  resources :groups do 
    member do
      get 'raffle'
    end
    resources :participants, only: [:create, :destroy, :show]
  end

  get '/participants/:id/confirm', :to => 'participants#confirm', :as => :confirm_participant
    
  authenticated :user do
    root 'groups#index', as: "authenticated_root"
  end

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
