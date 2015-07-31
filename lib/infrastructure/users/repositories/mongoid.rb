module Users
  module Repositories
    class Mongoid

      def register user_name
        UserDocument.create user_name: user_name
      end

      def registered? user_name
        UserDocument.find_by user_name: user_name
      rescue StandardError
        false
      end

    end
  end
end

class UserDocument

  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

end