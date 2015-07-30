require 'spec_helper'
require 'cos/actions/register_user'
require 'cos/core/users/exceptions'

describe Actions::RegisterUser do

  let(:users) { double('UsersRepository') }

  before do
    stub_const('Users::Repository', users)
  end

  it "tells users repository to register the user" do
    expect(users).to receive(:register).with('@foolano')

    Actions::RegisterUser.do('@foolano')
  end

  it "registers a new user" do
    allow(users).to receive(:register).with('@foolano')

    expect(Actions::RegisterUser.do('@foolano')).to be_truthy
  end

  it "tries to register an already registered user" do
    allow(users).to receive(:register).with('@foolano').and_raise(Users::AlreadyRegisteredError)

    expect(Actions::RegisterUser.do('@foolano')).to be_falsy
  end
end