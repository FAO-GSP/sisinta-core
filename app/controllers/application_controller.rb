# Base controller class.

class ApplicationController < ActionController::Base
  before_action :setup_global_search

  private

  def setup_global_search
    @global_search = Profile.search
  end
end
