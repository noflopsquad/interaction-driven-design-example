require 'spec_helper'
require 'infrastructure/repository_registry'
require 'infrastructure/users/repositories/in_memory'
require_relative 'users_repository_contract'

describe "In memory users repository" do

  before do
    RepositoryRegistry.register(:user, Users::Repositories::InMemory.new)
    @repo = RepositoryRegistry.for(:user)
  end

  it_behaves_like "users repository"
end
