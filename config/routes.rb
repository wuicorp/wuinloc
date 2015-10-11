Rails.application.routes.draw do
  root 'welcome#index'

  scope :api do
    scope :v1 do
      use_doorkeeper
    end
  end

  namespace :api do
    namespace :v1 do
      resources :flags, only: [:index, :create, :destroy], param: :code
    end
  end
end
