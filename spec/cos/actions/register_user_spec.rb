require 'spec_helper'
require 'cos/actions/register_user'

describe Actions::RegisterUser do

  let(:users_service) { double('UsersService') }

  before do
    stub_const('Users::UsersService', users_service)
  end

  it "tells users service to register the user" do
    expect(users_service).to receive(:register).with('@foolano')

    Actions::RegisterUser.do('@foolano')
  end

  it "registers a new user" do
    allow(users_service).to receive(:register).with('@foolano')

    expect(Actions::RegisterUser.do('@foolano')).to be_truthy
  end

  it "tries to register an already registered user" do
    allow(users_service).to receive(:register)
      .with('@foolano')
      .and_raise(Users::AlreadyRegisteredError)

    expect(Actions::RegisterUser.do('@foolano')).to be_falsy
  end
end