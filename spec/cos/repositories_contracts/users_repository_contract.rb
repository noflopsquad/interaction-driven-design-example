require 'spec_helper'

RSpec.shared_examples "users repository" do

  let(:user_name) { '@foolano' }
  let(:follower_name) { '@zutano' }
  let(:followed_name) { '@mengano' }

  it "knows when a user is registered" do
    given_already_registered(user_name)

    expect(@repo.registered?(user_name)).to be_truthy
  end

  it "knows when a user is not registered" do
    expect(@repo.registered?(user_name)).to be_falsy
  end

  it "registers a new user if username is not registered" do
    @repo.register(user_name)

    expect(@repo.registered?(user_name)).to be_truthy
  end

  it "adds a follower to a user" do
    given_both_already_registered(follower_name, followed_name)

    @repo.add_follower(follower_name, followed_name)

    expect(@repo.followers_of(followed_name)).to eq [follower_name]
  end

  def given_both_already_registered(follower_name, followed_name)
    given_already_registered(follower_name)
    given_already_registered(followed_name)
  end

  def given_already_registered(user_name)
    @repo.register(user_name)
  end
end
