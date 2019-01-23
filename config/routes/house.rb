resources :houses do
  member do
    post :deliver
  end
end
get 'houses/:id/json_data', action: :json_data, controller: 'houses'
  