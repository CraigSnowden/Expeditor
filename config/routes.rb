Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root "orders#index"
  resources :orders
  post "webhook" => "orders#webhook"
end
