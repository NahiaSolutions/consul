namespace :housesadmin do
  root to: "dashboard#index"

  resources :zonal_administrations, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :houses, only: [:show, :new, :create, :edit, :update, :destroy] do
      resources :workshops, only: [:new, :show, :create, :edit, :update, :destroy] do
        resources :workshop_users, only: [:edit, :update, :destroy]
        resources :workshop_images, only: [:new, :create, :edit, :update, :destroy]
      end
      resources :house_news, only: [:new, :create, :edit, :update, :destroy]
      resources :house_images, only: [:new, :create, :edit, :update, :destroy]
    end
  end

  resources :houses_age_ranges, only: [:index, :new, :create, :edit, :update]

end