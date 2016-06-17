Rails.application.routes.draw do
root "home#index"
resources :users
resources :sessions, only: [:new, :create] do
   delete :destroy, on: :collection
end
resources :posts do
resources :comments, only: [:create, :destroy]
end
#
get '/'           => 'home#index', as: :home
get '/about'      => 'home#about'
post '/'          => 'home#index'


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
