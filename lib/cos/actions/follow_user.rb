module Actions
  class FollowUser
    def self.do follower, followed
      Users::Repository.addFollower(follower, followed)
      true
    rescue Users::NotRegisteredError
      false
    end
  end
end