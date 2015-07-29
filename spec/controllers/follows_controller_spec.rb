require 'rails_helper'

RSpec.describe FollowsController, type: :controller do

  let(:action) { double('FollowUser') }
  let(:follower_name) { 'foolano' }
  let(:followed_name) { 'mengano' }

  before do
    stub_const('Actions::FollowUser', action)
  end

  describe "#follow" do
    it "delegates to follow user action" do
      expect(action).to receive(:do).with(follower_name, followed_name)

      post :follow, { follower: follower_name, followed: followed_name }
    end

    it "returns a JSON confirming that the following action was succesful " do
      allow(action).to receive(:do).with(follower_name, followed_name).and_return(true)

      post :follow, { follower: follower_name, followed: followed_name }

      expect(response.body).to eq({ follower: follower_name, followed: followed_name }.to_json)
      expect(response.status).to eq 200
    end

    it "returns a JSON with an error message if there was an error during the following action" do
      allow(action).to receive(:do).with(follower_name, followed_name).and_return(false)

      post :follow, { follower: follower_name, followed: followed_name }

      expect(response.body).to eq({ error: 'There was an error during the following action' }.to_json)
      expect(response.status).to eq 500
    end
  end
end
