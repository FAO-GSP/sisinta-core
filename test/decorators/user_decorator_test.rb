require 'test_helper'

class UserDecoratorTest < Draper::TestCase
  subject { user.decorate }

  describe 'name and email' do
    let(:user) { create :user, name: 'juan salvo', email: 'UpStringEmail@example.com' }

    it 'titleizes the name' do
      subject.name.must_equal 'Juan Salvo'
    end

    it 'downcases email' do
      subject.email.must_equal 'upstringemail@example.com'
    end

    it 'formats "name (email)"' do
      subject.name_and_email.must_equal 'Juan Salvo (upstringemail@example.com)'
    end
  end
end
