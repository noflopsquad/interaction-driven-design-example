require 'spec_helper'

RSpec.shared_examples "users repository" do
  it "registers a new user if username is not registered" do
    @repo.register('@foolano')

    expect(@repo.registered?('@foolano')).to be_truthy
  end

  it "raises AlreadyRegisteredError if user is registered" do
    @repo.register('@foolano')

    expect { @repo.register('@foolano') }.to raise_error(Users::AlreadyRegisteredError)
  end
end
