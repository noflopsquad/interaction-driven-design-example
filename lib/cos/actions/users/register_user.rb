module Actions
  class RegisterUser

    def self.do username
      if already_registered? username
        return false
      end

      Users::Repository.register username
      true
    end

    private

    def self.already_registered? username
      Users::Repository.registered? username
    end
  end
end
