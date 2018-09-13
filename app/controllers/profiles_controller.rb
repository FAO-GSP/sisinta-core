class ProfilesController < ApplicationController
  def index
    # Basic pagination
    @profiles = Profile.order(date: :desc).page(params[:page]).per(params[:page_size])

    # Return decorated objects to view
    @profiles = @profiles.decorate
  end

  def show
  end
end
