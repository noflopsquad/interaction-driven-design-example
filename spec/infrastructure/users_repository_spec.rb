require 'spec_helper'
require 'infrastructure/users/repositories/in_memory'
require 'users/exceptions'

describe "Users repository" do   

  before do
    RepositoryRegistry.register(:user, Users::Repositories::InMemory.new)
    @repo = RepositoryRegistry.for(:user)
  end

  it "registers a new user if username is not registered" do
    @repo.register('@foolano')

    expect(@repo.registered?('@foolano')).to be_truthy
  end

  it "raises AlreadyRegisteredError if user is registered" do
    @repo.register('@foolano')

    expect { @repo.register('@foolano') }.to raise_error(Users::AlreadyRegisteredError)
  end
end


class RepositoryRegistry
  def self.register type, repo
    repositories[type] = repo
  end

  def self.repositories
    @repositories ||= {}
  end

  def self.for(type)
    repositories[type]
  end
end