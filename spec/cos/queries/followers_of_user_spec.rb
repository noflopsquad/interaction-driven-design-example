require 'cos/queries/followers_of_user'

describe Queries::FollowersOfUser do

  let(:followed_name) {'pepito'}
  let(:users_service) {double('UsersService')}

  before do
    stub_const("Users::UsersService", users_service)
  end

  it "delegates to the users service" do
    expect(users_service).to receive(:followers_of).with(followed_name)

    Queries::FollowersOfUser.do(followed_name)
  end

end