Rails.application.routes.draw do
  root 'github#search'
  post '/', to: 'github#search'
end
