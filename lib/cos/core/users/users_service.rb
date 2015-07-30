require 'cos/core/users/exceptions'

module Users
  class UsersService
    def self.register(username)
      check_already_registered(username)
      Users::Repository.register username
    end

    def self.follow(follower_name, followed_name)
      check_both_registered(follower_name, followed_name)
      Users::Repository.add_follower(follower_name)
    end

    def self.followers_of(followed_name)
      Users::Repository.user_named(followed_name).followers
    end

    private
    def self.check_both_registered(follower_name, followed_name)
      raise Users::NotRegisteredError.new if any_not_registered?(follower_name, followed_name)
    end

    def self.any_not_registered?(follower_name, followed_name)
      !Users::Repository.registered?(follower_name) || !Users::Repository.registered?(followed_name)
    end

    def self.check_already_registered username
      raise Users::AlreadyRegisteredError.new if Users::Repository.registered? username
    end
  end
end