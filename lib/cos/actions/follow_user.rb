require 'cos/core/users/users_service'
require 'cos/core/users/exceptions'

module Actions
  class FollowUser
    def self.do follower, followed
      Users::UsersService.add_follower(follower, followed)
      true
    rescue Users::NotRegisteredError
      false
    end
  end
end