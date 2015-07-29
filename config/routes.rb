Rails.application.routes.draw do
  post 'register/:username' => 'registrations#register'

  post 'follow/:follower/:followed' => 'follows#follow'
end
