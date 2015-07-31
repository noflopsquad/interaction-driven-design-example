require 'spec_helper'
require 'infrastructure/users/repositories/mongoid'
require_relative '../cos/infrastructure/users_repository_contract'

describe "In memory users repository" do

  before do
    @repo = Users::Repositories::Mongoid.new
  end

  it_behaves_like "users repository"
end
