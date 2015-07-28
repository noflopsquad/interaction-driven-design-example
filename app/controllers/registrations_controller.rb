class RegistrationsController < ApplicationController

  def register
   action_result = Actions::RegisterUser.do params[:username]

   render_action_response action_result
  end


  private

  def render_action_response action_result
    if action_result
       render json: { username: params[:username] }, status: 200
    else
      render json: { error: "User #{params[:username]} is already registered" }, status: 500
    end
  end
end
