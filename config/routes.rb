Rails.application.routes.draw do
  root 'posts#index'

  resources :posts do
    collection do
      get :tags
    end
  end

  namespace :admin do
    root 'top#index'
    devise_for :admin_users, controllers: {
        registrations: 'admin/admin_user/registrations',
        sessions: 'admin/admin_user/sessions'
    }
    resources :posts
  end
end
