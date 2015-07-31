module Users
  module Repositories
    class InMemory

      def initialize
        @registered_users = {}
      end

      def register username
        add_new_user_named(username)
      end

      def registered? username
        contains_user_named?(username)
      end

      def add_follower(follower_name, followed_name)
        user_named(followed_name).add_follower(follower_name)
      end

      def followers_of(followed_name)
        user_named(followed_name).followers
      end

      private

      def user_named(username)
        @registered_users.fetch(username)
      end

      def contains_user_named?(username)
        @registered_users.has_key?(username)
      end

      def add_new_user_named(username)
        @registered_users[username] = User.new(username)
      end

      public
      class User
        attr_reader :username, :followers

        def initialize(username)
          @username = username
          @followers = []
        end

        def add_follower(follower_name)
          @followers << follower_name
        end

        def eql?(other)
          username = other.username
        end
      end
    end
  end
end
