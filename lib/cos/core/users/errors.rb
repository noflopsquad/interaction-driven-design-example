module Users
  class NonRegisteredError < StandardError
  end

  class AlreadyRegisteredError < StandardError
  end
end
