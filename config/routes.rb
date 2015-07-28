Rails.application.routes.draw do
  post 'register/:username' => 'registrations#register'
end
