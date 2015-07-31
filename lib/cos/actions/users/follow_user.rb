module Actions
  class FollowUser
    def self.do follower_name, followed_name
      if any_not_registered?(follower_name, followed_name)
        return false
      end

      Users::Repository.add_follower(follower_name, followed_name)
      true
    end

    private
    def self.any_not_registered?(follower_name, followed_name)
      !Users::Repository.registered?(follower_name) ||
        !Users::Repository.registered?(followed_name)
    end
  end
end
