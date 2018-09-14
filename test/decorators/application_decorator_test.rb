require 'test_helper'

class ApplicationDecoratorTest < Draper::TestCase
  subject { model.decorate }

  describe 'last_resort_identifier' do
    let(:model) { create :profile }

    it 'returns an identifier of class name and id' do
      subject.last_resort_identifier.must_match model.model_name.human
      subject.last_resort_identifier.must_match model.to_param
    end
  end
end
