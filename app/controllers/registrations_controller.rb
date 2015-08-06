class RegistrationsController < ApplicationController
  def register
    begin
      Actions::RegisterUser.do params[:username]
      render json: { username: params[:username] }, status: 200
    rescue Users::AlreadyRegisteredError
      render json: { error: "User #{params[:username]} is already registered" }, status: 500
    end
  end
end
