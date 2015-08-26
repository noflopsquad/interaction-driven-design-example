module Users
  module Errors
    class NonRegistered < StandardError
    end

    class AlreadyRegistered < StandardError
    end
  end
end
