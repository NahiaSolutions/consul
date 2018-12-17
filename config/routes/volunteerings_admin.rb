namespace :volunteerings_admin do
  root to: "dashboard#index"

  resources :volunt_categories, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :volunt_programs, only: [:show, :new, :create, :edit, :update, :destroy] do
      resources :volunt_users, only: [:destroy]
    end
  end
  
end