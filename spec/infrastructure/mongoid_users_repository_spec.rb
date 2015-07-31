require 'spec_helper'
require 'cos/infrastructure/repository_registry'
require 'infrastructure/users/repositories/mongoid'
require_relative '../cos/infrastructure/users_repository_contract'

describe "In memory users repository" do

  before do
    RepositoryRegistry.register(:user, Users::Repositories::Mongoid.new)
    @repo = RepositoryRegistry.for(:user)
  end

  it_behaves_like "users repository"
end
