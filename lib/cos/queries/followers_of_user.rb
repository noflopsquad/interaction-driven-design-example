module Queries
  class FollowersOfUser
    def self.do followed_name
      Users::Repository.followers_of(followed_name)
    end
  end
end
