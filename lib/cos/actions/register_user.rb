require 'cos/core/users/users_service'
require 'cos/core/users/exceptions'

module Actions
  class RegisterUser

    def self.do username
      Users::UsersService.register username
      true
    rescue Users::AlreadyRegisteredError
      false
    end
  end
end
