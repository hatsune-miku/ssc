Rails.application.routes.draw do
    root 'main#index'

    resources :upload
end
