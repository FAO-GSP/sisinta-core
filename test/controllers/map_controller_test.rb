require 'test_helper'

class MapControllerTest < ActionDispatch::IntegrationTest
  describe '#index' do
    it 'gets a response' do
      get map_index_url

      must_respond_with :success
    end
  end
end
