require 'sidekiq/web'

Rails.application.routes.draw do
  resources :pages do
    collection do
      get 'home'
      get 'image_manipulation'
      get 'process_image'
      get 'update_state'
      get 'process_file'
      get 'file_update_state'
    end
  end

  root 'pages#home'

  mount Sidekiq::Web, at: "/sidekiq"

end
