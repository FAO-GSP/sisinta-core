# Filter layer rows based on existing profiles.

module Etl
  module Wosis
    class FilterByProfile
      attr_reader :source

      def initialize(source:)
        @source = source
      end

      def process(row)
        profile = Profile.where(identifier: row[:profile_id], source: source).take

        # Return the row if there is a Profile for this combination of source
        # and identifier, preserving the id.
        if profile.present?
          row[:system_profile_id] = profile.id

          row
        else
          nil
        end
      end
    end
  end
end
