class FollowsController < ApplicationController

  def follow
    action_result = Actions::FollowUser.do params[:follower], params[:followed]
    if action_result
      render json: { follower: params[:follower], followed: params[:followed] }, status: 200
    else
      render json: { error: 'There was an error during the following action' }, status: 500
    end
  end
end
