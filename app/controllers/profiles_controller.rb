class ProfilesController < ApplicationController
  def index
    # Basic pagination
    @profiles = Profile.order(date: :desc).page params[:page]
  end

  def show
  end
end
