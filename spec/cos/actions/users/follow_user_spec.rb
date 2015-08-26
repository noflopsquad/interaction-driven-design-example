require 'spec_helper'
require 'cos/actions/users/follow_user'
require 'cos/core/users/errors'

describe Actions::FollowUser do

  let(:follower_name) { "foolano" }
  let(:followed_name) { "mengano" }
  let(:users_repository) { double('UsersRepository') }

  before do
    stub_const('Users::Repository', users_repository)
  end

  describe "Following a user" do
    describe "when both users are registered" do
      it "succesfully adds a follower to a followed user" do
        allow(users_repository).
          to receive(:registered?).with(follower_name).and_return(true)
        allow(users_repository).
          to receive(:registered?).with(followed_name).and_return(true)
        expect(users_repository).
          to receive(:add_follower).with(follower_name, followed_name)

        Actions::FollowUser.do follower_name, followed_name
      end
    end

    describe "when any of them is not registered" do
      it "raises an error when trying to add a registered follower to a followed user that does not exist" do
        allow(users_repository).
          to receive(:registered?).with(follower_name).and_return(true)
        allow(users_repository).
          to receive(:registered?).with(followed_name).and_return(false)

        expect {Actions::FollowUser.do follower_name, followed_name}.
          to raise_error(Users::Errors::NonRegistered)
      end

      it "raises an error when trying to add a follower that does not exist to a registered followed user" do
        allow(users_repository).
          to receive(:registered?).with(follower_name).and_return(false)
        allow(users_repository).
          to receive(:registered?).with(followed_name).and_return(true)

        expect{Actions::FollowUser.do follower_name, followed_name}.
          to raise_error(Users::Errors::NonRegistered)
      end
    end
  end
end
