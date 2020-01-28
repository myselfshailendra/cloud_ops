Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'service/:service_code/region/:location', to: 'regions#show_region_prices', as: :show_region_prices
    end
  end
end
