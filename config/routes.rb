Rails.application.routes.draw do
  post 'register/:username' => 'registrations#register'

  post 'follow/:follower/:followed' => 'follows#follow'

  get 'followers/:followed' => 'follows#followers'
end
