Rails.application.routes.draw do
  root "users#index"

  resources :users do
    resources :texts
  end

  resource :texts do
    collection do
      post "reply"
    end
  end
end
