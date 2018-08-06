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
  end
end
