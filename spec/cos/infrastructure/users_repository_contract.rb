require 'spec_helper'

RSpec.shared_examples "users repository" do

  describe "User registration" do
    it "registers a new user if username is not registered" do
      @repo.register('@foolano')

      expect(@repo.registered?('@foolano')).to be_truthy
    end

    it "raises AlreadyRegisteredError if user is registered" do
      @repo.register('@foolano')

      expect { @repo.register('@foolano') }.to raise_error(Users::AlreadyRegisteredError)
    end
  end

  describe "Adding a follower" do
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

    describe "when any of them is not registered" do
      it "raises an error when trying to add a registered follower to a followed user that does not exist" do
        @repo.register(follower)

        expect { @repo.add_follower(follower, followed) }.to raise_error(Users::NotRegisteredError)
      end

      it "raises an error when trying to add a follower that does not exist to a registered followed user" do
        @repo.register(followed)

        expect { @repo.add_follower(follower, followed) }.to raise_error(Users::NotRegisteredError)
      end
    end
  end
end
