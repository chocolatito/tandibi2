Rails.application.routes.draw do
  # namespace :settings do
  #   get 'users/show'
  #   get 'users/update'
  # end
  # get 'posts/create'
  # get 'timelines/index'
  # get 'timelines/show'
  devise_for :users
  root to: 'home#index'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  namespace :settings do
    resource :user, only: %i[show update]
  end
  authenticate :user do
    resources :timelines,
              only: %i[index show],
              param: :username
    resources :posts, only: %i[create show]
    resources :bonds, param: :username do
      member do
        post :follow
        post :unfollow
        post :accept
        post :reject
        get :followers
        get :following
      end
    end
  end
  namespace :api do
    namespace :v1 do
      resources :places, only: [:index]
    end
  end
end
