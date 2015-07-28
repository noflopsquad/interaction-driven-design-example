module Actions
  class RegisterUser

    def self.do username
      Users::Repository.register username
      true
    rescue Users::AlreadyRegisteredError
      false
    end
  end
end
