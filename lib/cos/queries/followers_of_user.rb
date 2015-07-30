require 'cos/core/users/users_service'

module Queries
  class FollowersOfUser
    def self.do followed_name
      Users::UsersService.followers_of(followed_name)
    end
  end
end