require 'spec_helper'
require 'cos/actions/follow_user'
require 'cos/core/users/exceptions'

describe Actions::FollowUser do
  let(:repo) { double('UsersRepo') }
  let(:follower) { "foolano" }
  let(:followed) { "mengano" }

  before do
    stub_const('Users::Repository', repo)
  end

  it "tells the users repository to add a new follower to the followed user" do
    expect(repo).to receive(:addFollower).with(follower, followed)

    Actions::FollowUser.do follower, followed
  end

  it "succesfully adds a new follower to the followed user" do
    allow(repo).to receive(:addFollower).with(follower, followed)

    expect(Actions::FollowUser.do follower, followed).to be_truthy
  end

  it "adds a new follower to the followed user but fails because one or both of them are not registered" do
    allow(repo).to receive(:addFollower).with(follower, followed).and_raise(
      Users::NotRegisteredError
    )

    expect(Actions::FollowUser.do follower, followed).to be_falsy
  end
end