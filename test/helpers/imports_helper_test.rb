require 'test_helper'

class ImportsHelperTest < ActionView::TestCase
  # Defining methods here allows stubbing and calling by the included module.
  def import
    nil
  end

  describe ImportsHelper do
    describe '#selected_for' do
      it 'returns the corresponding id from an array of integers' do
        type = create :metadata_type

        stub :import, CsvImport.new(metadata: [type.id]) do
          selected_for(type.field_name).must_equal type.id
        end
      end

      it 'returns the corresponding id from an array of strings' do
        type = create :metadata_type

        stub :import, CsvImport.new(metadata: [type.id.to_s]) do
          selected_for(type.field_name).must_equal type.id
        end
      end
    end
  end
end
