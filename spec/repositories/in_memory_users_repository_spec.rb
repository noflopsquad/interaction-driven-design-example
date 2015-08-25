require 'spec_helper'
require 'infrastructure/users/repositories/in_memory'
require_relative '../cos/repositories_contracts/users_repository_contract'

describe "In memory users repository" do

  before do
    @repo = Users::Repositories::InMemory.new
  end

  it_behaves_like "users repository"
end
