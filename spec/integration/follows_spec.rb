require 'rails_helper'

RSpec.describe FollowsController, type: :controller do

  let(:followed_name) { 'mengano' }

  describe "#follow" do
    let(:follower_name) { 'foolano' }

    it "returns a JSON confirming that the action was succesful" do
      Users::Repository.register follower_name
      Users::Repository.register followed_name

      post :follow, { follower: follower_name, followed: followed_name }

      expect(response.body).to eq({ follower: follower_name, followed: followed_name }.to_json)
      expect(response.status).to eq 200
    end

    it "returns a JSON with an error message if there was an error during the following action" do
      post :follow, { follower: follower_name, followed: followed_name }

      expect(response.body).to eq({ error: 'There was an error during the following action' }.to_json)
      expect(response.status).to eq 500
    end
  end

  describe "#followers" do

    it "returns a JSON with the list of followers" do
      Users::Repository.register followed_name
      Users::Repository.add_follower "pepe", followed_name
      Users::Repository.add_follower "koko", followed_name

      get :followers, {followed: followed_name}

      expect(response.body).to eq({followers: ['pepe', 'koko']}.to_json)
      expect(response.status).to eq(200)
    end

  end
end
