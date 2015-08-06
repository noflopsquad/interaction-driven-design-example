require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  describe "#register" do

    let(:action) { double('RegisterUser') }

    before do
      stub_const('Actions::RegisterUser', action)
    end

    it "returns a JSON with the registered username when registration is successful" do
      expect(action).to receive(:do).with('@foolano')

      post :register, { username: '@foolano' }

      expect(response.body).to eq({ username: '@foolano' }.to_json)
      expect(response.status).to eq 200
    end


    it "returns a JSON with an error message when the username is already registered" do
      allow(action).to receive(:do).with('@foolano').
        and_raise(Users::AlreadyRegisteredError)

      post :register, { username: '@foolano' }

      expect(response.body).to eq({ error: 'User @foolano is already registered' }.to_json)
      expect(response.status).to eq 500
    end
  end
end
