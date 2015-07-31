require 'spec_helper'
require 'cos/actions/follow_user'

describe Actions::FollowUser do
  let(:users_service) { double('UsersService') }
  let(:follower) { "foolano" }
  let(:followed) { "mengano" }

  before do
    stub_const('Users::UsersService', users_service)
  end

  it "tells the users service to add a new follower to the followed user" do
    expect(users_service).to receive(:follow).with(follower, followed)

    Actions::FollowUser.do follower, followed
  end

  it "succesfully adds a new follower to the followed user" do
    allow(users_service).to receive(:follow).with(follower, followed)

    expect(Actions::FollowUser.do follower, followed).to be_truthy
  end

  it "fails adding a new follower to the followed user because one or both of them are not registered" do
    allow(users_service).to receive(:follow).with(follower, followed).and_raise(
      Users::NotRegisteredError
    )

    expect(Actions::FollowUser.do follower, followed).to be_falsy
  end
end