Rails.application.routes.draw do
  # Subdomain-scoped routes
  constraints subdomain: /.+/ do
    #devise_for :users

    devise_for :users, controllers: {
      registrations: 'users/registrations',
      sessions: 'users/sessions'
    }

    resources :posts

    # Rename this route to avoid name conflict
    root to: 'posts#index', as: :organization_root
  end

  # Default root for main domain
  # root to: 'home#index'
end