Rails.application.routes.draw do
  root to: 'application#welcome'

  namespace :api do
    namespace :v1, defaults: { format: 'json' } do
      resources :transactions do
        resources :bank_guarantees, only: [:create, :update], shallow: true
      end
    end
  end
end
