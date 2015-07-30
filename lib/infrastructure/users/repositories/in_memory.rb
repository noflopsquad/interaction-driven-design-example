require 'cos/core/users/user'

module Users
  module Repositories
    class InMemory

      def initialize
        @registered_users = {}
      end

      def register username
        check_already_registered(username)
        add_new_user_named(username)
      end

      def registered? username
        contains_user_named?(username)
      end

      def add_follower(follower_name, followed_name)
        check_both_registered(follower_name, followed_name)
        user_named(followed_name).add_follower(follower_name)
      end

      def followers_of(followed_name)
        user_named(followed_name).followers
      end

      private

      def check_already_registered username
        raise Users::AlreadyRegisteredError.new if registered? username
      end

      def check_both_registered(follower_name, followed_name)
        raise Users::NotRegisteredError.new if any_not_registered?(follower_name, followed_name)
      end

      def contains_user_named?(username)
        @registered_users.has_key?(username)
      end

      def user_named(username)
        @registered_users.fetch(username)
      end

      def add_new_user_named(username)
        @registered_users[username] = User.new(username)
      end

      def any_not_registered?(follower_name, followed_name)
        !registered?(follower_name)|| !registered?(followed_name)
      end
    end
  end
end