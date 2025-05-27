Rails.application.routes.draw do
  resources :sucursales do
  collection do
    get :import
    post :import_create
  end
end

  resources :bodegas
  resources :productos do
  collection do
    get :import
    post :import_create
  end
end

  root 'nav#index'

  get "up" => "rails/health#show", as: :rails_health_check

end
