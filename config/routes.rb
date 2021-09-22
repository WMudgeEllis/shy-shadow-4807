Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :plots
  resources :plants

  resources :plots do
    resources :plants
  end

end
