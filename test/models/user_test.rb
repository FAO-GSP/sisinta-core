require 'test_helper'

class UserTest < ActiveSupport::TestCase
  describe 'validations' do
    it 'requires an email' do
      build(:user, email: nil).wont_be :valid?
      build(:user, email: 'some-email@example.com').must_be :valid?
    end

    it 'requires a password' do
      build(:user, password: nil).wont_be :valid?
      build(:user, password: 'some password').must_be :valid?
    end

    it 'requires a name' do
      build(:user, name: nil).wont_be :valid?
      build(:user, name: 'Juan Salvo').must_be :valid?
    end
  end

  describe 'admin' do
    it 'defaults to false' do
      User.new.wont_be :admin?
    end
  end
end
