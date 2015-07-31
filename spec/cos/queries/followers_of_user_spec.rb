require 'spec_helper'
require 'cos/queries/followers_of_user'

describe Queries::FollowersOfUser do

  let(:follower_names) {["pepe", "juan"]}
  let(:followed_name) {"koko"}
  let(:users_repository) { double('UsersRepository') }

  before do
    stub_const('Users::Repository', users_repository)
  end

  describe "Getting the followers of a user" do
    it "collaborates with the users repository to get the list of followers" do
      allow(users_repository).to receive(:followers_of)
      .with(followed_name)
      .and_return(follower_names)

      expect(Queries::FollowersOfUser.do(followed_name)).to eq follower_names
    end
  end
end
