module Actions
  class FollowUser
    def self.do follower, followed
      Users::Repository.registered? follower
      Users::Repository.registered? followed
    end
  end
end