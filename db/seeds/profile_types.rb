# Possible values for Profile type
#
# Id is set because these are lookup tables of value objects, mostly static
# data
profile_types = [
  { id: 1, value: 'perfil de suelo' },
  { id: 2, value: 'auger' }
]

profile_types.each do |profile_type|
  # If any value was changed by application users, do not touch it
  unless ProfileType.exists?(profile_type[:id])
    ProfileType.find_or_create_by(profile_type).update_column(:id, profile_type[:id])
  end
end
