require 'spec_helper'
require 'cos/actions/follow_user'

describe Actions::FollowUser do

  let(:follower_name) { "foolano" }
  let(:followed_name) { "mengano" }
  let(:users_repository) { double('UsersRepository') }

  before do
    stub_const('Users::Repository', users_repository)
  end

  describe "when both users are registered" do
    it "succesfully adds a follower to a followed user" do
      allow(users_repository).to receive(:registered?).with(follower_name).and_return(true)
      allow(users_repository).to receive(:registered?).with(followed_name).and_return(true)
      expect(users_repository).to receive(:add_follower)

      expect(Actions::FollowUser.do follower_name, followed_name).to be_truthy
    end
  end

  describe "when any of them is not registered" do
    it "raises an error when trying to add a registered follower to a followed user that does not exist" do
      allow(users_repository).to receive(:registered?).with(follower_name).and_return(true)
      allow(users_repository).to receive(:registered?).with(followed_name).and_return(false)

      expect(Actions::FollowUser.do follower_name, followed_name).to be_falsy
    end

    it "raises an error when trying to add a follower that does not exist to a registered followed user" do
      allow(users_repository).to receive(:registered?).with(follower_name).and_return(false)
      allow(users_repository).to receive(:registered?).with(followed_name).and_return(true)

      expect(Actions::FollowUser.do follower_name, followed_name).to be_falsy
    end
  end
end
