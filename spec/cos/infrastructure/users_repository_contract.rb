require 'spec_helper'

RSpec.shared_examples "users repository" do

  describe "Registering a user" do
    it "registers a new user if username is not registered" do
      @repo.register('@foolano')

      expect(@repo.registered?('@foolano')).to be_truthy
    end
  end

  describe "Adding a follower to a user" do
    let(:follower) { '@foolano' }
    let(:followed) { '@mengano' }

    describe "when both users are registered" do
      it "adds a follower to a followed user" do
        @repo.register(follower)
        @repo.register(followed)

        @repo.add_follower(follower, followed)

        expect(@repo.followers_of(followed)).to eq [follower]
      end
    end
  end

  describe "Querying for a user" do
    it "queries for a user given its name" do
      @repo.register("koko")

      expect(@repo.user_named("koko")).to eql User.new("koko")
    end
  end
end
