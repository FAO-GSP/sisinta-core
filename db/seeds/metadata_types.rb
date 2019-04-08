# Possible values for Profile type.

# Id is set because these are lookup tables of value objects, mostly static
# data.
#
metadata_types = [
  { id: 1, field_name: 'order', value: 'Soil classification FAO' },
  { id: 2, field_name: 'order', value: 'Soil classification WRB' },
  { id: 3, field_name: 'order', value: 'Soil classification Soil Taxonomy' },

  { id: 4, field_name: 'bulk_density', value: 'PTFs' },
  { id: 5, field_name: 'bulk_density', value: 'Fine earth fraction*, equilibrated at 33 kPa' },
  { id: 6, field_name: 'bulk_density', value: 'Fine earth fraction*, air dried' },
  { id: 7, field_name: 'bulk_density', value: 'Whole soil including coarse fragments, oven dry' },

  { id: 8, field_name: 'ca_co3', value: 'dissolution by HCl' },
  { id: 9, field_name: 'ca_co3', value: 'dissolution by H2SO4' },

  { id: 10, field_name: 'coarse_fragments', value: 'Coarse fragments gravimetric total' },
  { id: 11, field_name: 'coarse_fragments', value: 'Coarse fragments volumetric total' },

  { id: 12, field_name: 'ecec', value: 'Summation of exchangeable bases' },
  { id: 13, field_name: 'ecec', value: 'CEC - buffered at pH7' },
  { id: 14, field_name: 'ecec', value: 'CEC - buffered at pH8' },

  { id: 15, field_name: 'conductivity', value: 'Saturated paste' },
  { id: 16, field_name: 'conductivity', value: 'Ratio 1:1' },
  { id: 17, field_name: 'conductivity', value: 'Ratio 1:2.5' },

  { id: 18, field_name: 'organic_carbon', value: 'Dry combustion' },
  { id: 19, field_name: 'organic_carbon', value: 'Walkley-Black' },
  { id: 20, field_name: 'organic_carbon', value: 'A-I colorimetric' },

  { id: 21, field_name: 'ph', value: '1:1 CaCl2' },
  { id: 22, field_name: 'ph', value: '1:2.5 CaCl2' },
  { id: 23, field_name: 'ph', value: '1:5 CaCl2' },
  { id: 24, field_name: 'ph', value: '1:1 water' },
  { id: 25, field_name: 'ph', value: '1:2.5 water' },
  { id: 26, field_name: 'ph', value: 'soil solution' },
  { id: 27, field_name: 'ph', value: '1:1 KCl' },
  { id: 28, field_name: 'ph', value: '1:2.5 KCl' },
  { id: 29, field_name: 'ph', value: '1:5 KCl' },

  { id: 30, field_name: 'clay', value: '< 2 um hydrometer' },
  { id: 31, field_name: 'clay', value: '< 2 um pipette' },

  { id: 32, field_name: 'silt', value: '2-20 um hydrometer' },
  { id: 33, field_name: 'silt', value: '2-20 um pipette' },
  { id: 34, field_name: 'silt', value: '2-50 um hydrometer' },
  { id: 35, field_name: 'silt', value: '2-50 um pipette' },

  { id: 36, field_name: 'sand', value: '20-2000 um hydrometer' },
  { id: 37, field_name: 'sand', value: '20-2000 um pipette' },
  { id: 38, field_name: 'sand', value: '50-2000 um hydrometer' },
  { id: 39, field_name: 'sand', value: '50-2000 um pipette' }
]

metadata_types.each do |metadata_type|
  # If any value was changed by application users, do not touch it.
  unless MetadataType.exists?(metadata_type[:id])
    MetadataType.create!(metadata_type).update_column(:id, metadata_type[:id])
  end
end
