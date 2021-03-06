require 'spec_helper'
require 'cos/actions/users/register_user'
require 'cos/core/users/errors'

describe Actions::RegisterUser do

  let(:users_repository) { double('UsersRepository') }
  let(:new_user_name) {'@foolano'}

  before do
    stub_const('Users::Repository', users_repository)
  end

  describe "Registering a user" do
    it "can register a user that is not already registered" do
      allow(users_repository).
        to receive(:registered?).
        with(new_user_name).and_return(false)
      expect(users_repository).
        to receive(:register).with(new_user_name)

      Actions::RegisterUser.do(new_user_name)
    end

    it "fails when trying to register a user that is already registered" do
      allow(users_repository).
        to receive(:registered?).with(new_user_name).and_return(true)

      expect{Actions::RegisterUser.do(new_user_name)}.
        to raise_error(Users::Errors::AlreadyRegistered)
    end
  end
end
