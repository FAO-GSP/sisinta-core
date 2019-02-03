# Wrapper for the companion R API

class Rapi
  include HTTParty

  base_uri Rails.configuration.x['rapi']['base_path']

  attr_accessor :data

  def initialize(data)
    self.data = data
  end

  def process(name)
    response = Rapi.post(
      "/#{name}",
      body: data,
      headers: { 'charset' => 'utf-8' }
    )
  end

  def plot_spc
    process 'plot_spc'
  end

  def plot_slabs
    process 'plot_slabs'
  end

  def dissimilarity
    process 'dissimilarity'
  end
end
