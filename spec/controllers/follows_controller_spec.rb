require 'rails_helper'

RSpec.describe FollowsController, type: :controller do

  describe "#follow" do
    let(:action) { double('FollowUser') }
    let(:follower_name) { 'foolano' }
    let(:followed_name) { 'mengano' }

    before do
      stub_const('Actions::FollowUser', action)
    end

    it "returns a JSON confirming that the action was succesful" do
      expect(action).to receive(:do).with(follower_name, followed_name)

      post :follow, { follower: follower_name, followed: followed_name }

      expect(response.body).to eq({ follower: follower_name, followed: followed_name }.to_json)
      expect(response.status).to eq 200
    end

    it "returns a JSON with an error message if there was an error during the following action" do
      allow(action).
        to receive(:do).with(follower_name, followed_name).
        and_raise(Users::NonRegisteredError)

      post :follow, { follower: follower_name, followed: followed_name }

      expect(response.body).to eq({ error: 'There was an error during the following action' }.to_json)
      expect(response.status).to eq 500
    end
  end

  describe "#followers" do
    let(:followed_name) { 'mengano' }
    let(:query) { double('FollowersOfUser') }

    before do
      stub_const('Queries::FollowersOfUser', query)
    end

    it "delegates to followers query" do
      expect(query).to receive(:do).with(followed_name)

      get :followers, {followed: followed_name}
    end

    it "returns a JSON with the list of followers" do
      allow(query).to receive(:do).with(followed_name).and_return(['pepe', 'koko'])

      get :followers, {followed: followed_name}

      expect(response.body).to eq({followers: ['pepe', 'koko']}.to_json)
      expect(response.status).to eq(200)
    end

  end
end
