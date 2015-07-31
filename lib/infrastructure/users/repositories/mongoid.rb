module Users
  module Repositories
    class Mongoid

      def register user_name
        UserDocument.create user_name: user_name
      end

      def registered? user_name
        UserDocument.find_by user_name: user_name
      rescue StandardError
        false
      end

      def add_follower follower_name, followed_name
        FollowersDocument.create follower_name: follower_name, followed_name: followed_name
      end

      def followers_of followed_name
        FollowersDocument.where(followed_name: followed_name).pluck(:follower_name)
      end

    end
  end
end

class FollowersDocument

  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

end

class UserDocument

  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

end