require 'spec_helper'

RSpec.shared_examples "users repository" do

  describe "Registering a user" do
    let(:user_name) { '@foolano' }

    it "registers a new user if username is not registered" do
      @repo.register(user_name)

      expect(@repo.registered?(user_name)).to be_truthy
    end

    it "knows when a user is not registered" do
      expect(@repo.registered?(user_name)).to be_falsy
    end
  end

  describe "Adding a follower to a user" do
    let(:follower_name) { '@foolano' }
    let(:followed_name) { '@mengano' }

    describe "when both users are registered" do
      it "adds a follower to a followed user" do
        @repo.register(follower_name)
        @repo.register(followed_name)

        @repo.add_follower(follower_name, followed_name)

        expect(@repo.followers_of(followed_name)).to eq [follower_name]
      end
    end
  end

end
