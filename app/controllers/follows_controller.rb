require 'cos/core/users/errors'

class FollowsController < ApplicationController

  def follow
    begin
      Actions::FollowUser.do params[:follower], params[:followed]
      render json: { follower: params[:follower], followed: params[:followed] }, status: 200
    rescue Users::NonRegisteredError
      render json: { error: 'There was an error during the following action' }, status: 500
    end
  end

  def followers
    followers_list = Queries::FollowersOfUser.do params[:followed]

    render json: {followers: followers_list}, status: 200
  end
end
