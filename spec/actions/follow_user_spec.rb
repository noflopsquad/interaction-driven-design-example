require 'spec_helper'
require 'actions/follow_user'


describe Actions::FollowUser do
  let(:repo) { double('UsersRepo') }  


  before do
    stub_const('Users::Repository', repo)
  end

  it "asks users repository if both users exist" do
    follower = 'foolano'
    followed = 'mengano'

    expect(repo).to receive(:registered?).with(follower)
    expect(repo).to receive(:registered?).with(followed)

    Actions::FollowUser.do follower, followed
  end

end