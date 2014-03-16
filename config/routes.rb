Turly::Application.routes.draw do
 
root "urls#index"

match 'urls/create' => 'urls#create', :as=>:create, :via => :post
match "urls/index" => "urls#index", :as => :index, :via=> :get
get ':link', to: 'urls#show'


end
