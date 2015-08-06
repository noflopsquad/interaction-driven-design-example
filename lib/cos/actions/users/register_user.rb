require 'cos/core/users/errors'

module Actions
  class RegisterUser

    def self.do username
      if already_registered? username
        raise Users::AlreadyRegisteredError
      end

      Users::Repository.register username
    end

    private

    def self.already_registered? username
      Users::Repository.registered? username
    end
  end
end
