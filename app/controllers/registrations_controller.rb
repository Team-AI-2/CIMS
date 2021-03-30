class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, :only => [:create]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:f_name, :l_name, :email, :password, :club_id, :position_id])
  end
end