Rails.application.routes.draw do
  root "orders#index"
  resources :orders
  post "webhook" => "orders#webhook"
end
