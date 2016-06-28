Rails.application.routes.draw do
resources :stars
root "home#index"
resources :users
resources :sessions, only: [:new, :create] do
   delete :destroy, on: :collection
end
resources :favourites, only: [:index]
resources :posts do
resources :stars, only: [:create, :update, :destroy]
resources :comments, only: [:create, :destroy]
resources :favourites, only: [:create, :destroy]
end
#
get    '/'                => 'home#index', as: :home
get    '/about'           => 'home#about'
post   '/'                => 'home#index'
get    '/passwordrequest' => 'home#password', as: :password
post   '/passwordrequest' => 'home#token'
get    '/passwordreset'   => 'home#passwordreset', as: :passwordreset
patch  '/passwordreset'   => 'users#resetpassword'


# get '/posts'      => 'posts#index'
# get '/posts/new'  => 'posts#new'
# post  '/posts'                => "posts#add"
# get   '/posts/:id'            => 'posts#show',  as: :post
# get   '/posts/:id/edit'       => 'posts#edit',     as: :edit
# patch '/posts/:id'            => "posts#update"
# delete "/posts/:id"           => "posts#destroy"
# #############################################################
# get  "/comments/new"   => 'comments#new'
# post "/commnets"       => 'commnets#create',   as: :comments_new_path


end
