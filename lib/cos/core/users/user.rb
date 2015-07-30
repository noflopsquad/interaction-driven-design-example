class User
  attr_reader :username, :followers

  def initialize(username)
    @username = username
    @followers = []
  end

  def add_follower(follower_name)
    @followers << follower_name
  end
end