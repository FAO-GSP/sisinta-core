# Transforms WoSIS CSV data into the format understood by SiSINTA.

module Etl
  module Wosis
    class FormatToSisintaLayers
      def process(row)
        row[:layer_identifier] = row.delete(:profile_layer_id).last
        row[:bulk_density] = row.delete(:bdws_value_avg).last
        row[:ca_co3] = row.delete(:tceq_value_avg).last
        row[:coarse_fragments] = row.delete(:cfvo_value_avg).last
        row[:ecec] = row.delete(:ecec_value_avg).last
        row[:conductivity] = row.delete(:elco_value_avg).last
        row[:organic_carbon] = row.delete(:orgc_value_avg).last
        # FIXME Preserve metadata (ph H2O 2.5)
        row[:ph] = row.delete(:phaq_value_avg).last
        row[:clay] = row.delete(:clay_value_avg).last
        row[:silt] = row.delete(:silt_value_avg).last
        row[:sand] = row.delete(:sand_value_avg).last
        row[:water_retention] = row.delete(:wrvo_value_avg).last

        row
      end
    end
  end
end
