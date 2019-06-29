# Layer presentation methods.

class LayerDecorator < ApplicationDecorator
  decorates_association :profile

  def display_name
    identifier
  end

  def bulk_density
    object.bulk_density.try(:round, 2)
  end

  def ca_co3
    object.ca_co3.try(:round, 2)
  end

  def coarse_fragments
    object.coarse_fragments.try(:round, 2)
  end

  def ecec
    object.ecec.try(:round, 2)
  end

  def conductivity
    object.conductivity.try(:round, 2)
  end

  def organic_carbon
    object.organic_carbon.try(:round, 2)
  end

  def ph
    object.ph.try(:round, 2)
  end

  def clay
    object.clay.try(:round, 2)
  end

  def silt
    object.silt.try(:round, 2)
  end

  def sand
    object.sand.try(:round, 2)
  end

  def water_retention
    object.water_retention.try(:round, 2)
  end
end
