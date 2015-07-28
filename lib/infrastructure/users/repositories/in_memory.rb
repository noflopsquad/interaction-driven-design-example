module Users
  module Repositories
    class InMemory

      def initialize
        @registries = []
      end

      def register username
        check_already_registered username
        @registries << username
      end

      def registered? username
        @registries.include?(username)
      end


      private
      def check_already_registered username
        raise Users::AlreadyRegisteredError.new if registered? username
      end
    end
  end
end