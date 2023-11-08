Rails.application.routes.draw do
  post 'robots/move'
  post 'robots/left'
  post 'robots/right'
  post 'robots/report'
  post 'robots/place'
  root 'simulator#index'
end
