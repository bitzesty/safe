ActionController::Routing::Routes.draw do |map|
  map.resources :safe_cabinets,
    :member     => [:unlock],
    :only       => [:show, :unlock]
end
