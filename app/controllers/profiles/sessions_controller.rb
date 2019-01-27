class Profiles::SessionsController < Devise::SessionsController

  def destroy
    current_profile.invalidate_session!
    super
  end

end