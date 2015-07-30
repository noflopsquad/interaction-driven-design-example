require 'cos/core/users/users_service'
require 'cos/core/users/exceptions'
require 'cos/core/users/user'

describe "users service" do
  let(:users_repository) { double('UsersRepository') }

  before do
    stub_const('Users::Repository', users_repository)
  end

  describe "User registration" do
    let(:new_user) { '@foolano' }

    it "tells users repository to register the user" do
      allow(users_repository).to receive(:registered?).with(new_user).and_return(false)
      expect(users_repository).to receive(:register).with(new_user)

      Users::UsersService.register(new_user)
    end

    it "raises AlreadyRegisteredError if user is already registered" do
      allow(users_repository).to receive(:registered?).with(new_user).and_return(true)

      expect { Users::UsersService.register(new_user) }.to raise_error(Users::AlreadyRegisteredError)
    end
  end

  describe "Following a user" do
    let(:follower) { '@foolano' }
    let(:followed) { '@mengano' }

    describe "when both users are registered" do
      it "adds a follower to a followed user" do
        allow(users_repository).to receive(:registered?).with(follower).and_return(true)
        allow(users_repository).to receive(:registered?).with(followed).and_return(true)
        expect(users_repository).to receive(:add_follower)

        Users::UsersService.follow(follower, followed)
      end
    end

    describe "when any of them is not registered" do
      it "raises an error when trying to add a registered follower to a followed user that does not exist" do
        allow(users_repository).to receive(:registered?).with(follower).and_return(true)
        allow(users_repository).to receive(:registered?).with(followed).and_return(false)

        expect { Users::UsersService.follow(follower, followed) }.to raise_error(Users::NotRegisteredError)
      end

      it "raises an error when trying to add a follower that does not exist to a registered followed user" do
        allow(users_repository).to receive(:registered?).with(follower).and_return(false)
        allow(users_repository).to receive(:registered?).with(followed).and_return(true)

        expect { Users::UsersService.follow(follower, followed) }.to raise_error(Users::NotRegisteredError)
      end
    end

    describe "getting the followers of a user" do
      let(:follower_names) {["pepe", "juan"]}
      let(:followed_user_name) {"koko"}

      it "collaborates with the users repository to get the list of followers" do
        allow(users_repository).to receive(:user_named)
          .with(followed_user_name)
          .and_return(a_user_with_some_followers(followed_user_name, follower_names))

        followers = Users::UsersService.followers_of(followed_user_name)

        expect(followers).to eq follower_names
      end

      def a_user_with_some_followers(followed_user_name, follower_names)
        followed_user = User.new(followed_user_name)
        follower_names.each do |follower_name|
          followed_user.add_follower(follower_name)
        end
        followed_user
      end
    end
  end
end