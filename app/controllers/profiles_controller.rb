class ProfilesController < ApplicationController
  before_action :authenticate_profile!
  before_action :set_profile, only: [:show]

  # GET /profiles/1
  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = Profile.find(params[:id])
  end
end
