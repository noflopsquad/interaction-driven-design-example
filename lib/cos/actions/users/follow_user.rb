require 'cos/core/users/errors'

module Actions
  class FollowUser
    def self.do follower_name, followed_name
      if any_not_registered?(follower_name, followed_name)
        raise Users::NonRegisteredError
      end

      Users::Repository.add_follower(follower_name, followed_name)
    end

    private
    def self.any_not_registered?(follower_name, followed_name)
      !Users::Repository.registered?(follower_name) ||
        !Users::Repository.registered?(followed_name)
    end
  end
end
