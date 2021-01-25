class Devise::RegistrationsController < DeviseController
  prepend_before_action :require_no_authentication, only: [:new, :create, :cancel]
  prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy]
  # GET /resource/sign_up
  def new
    @session_var = ''
    if !session["devise.user_attributes"].nil?
      @session_var = session["devise.user_attributes"]["email"]
    end
    build_resource({})
    @validatable = devise_mapping.validatable?
    if @validatable
      @minimum_password_length = resource_class.password_length.min
    end
    session["devise.user_attributes"] = nil
  end

  def csrf
    respond_to do |format|
      format.json do
      end
    end
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    resource_saved = false # resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with resource
    end
  end

  # GET /resource/edit
  def edit
    @member = current_member
    render :edit
  end

  # PUT /resource
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    if session["oauth"] == "true"
      resource_updated = resource.update(:password => account_update_params[:password], :password_confirmation => account_update_params[:password_confirmation])
    else
      resource_updated = update_resource(resource, account_update_params)
    end
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
                      :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      flash[:notice] = message
      flash[:alert] = "#{alert} #{error}" unless alert.nil?
      redirect_to after_update_path_for(resource)
    else
      clean_up_passwords resource
      redirect_to "/"
    end
  end

  # DELETE /resource
  def destroy
    redirect_to "/", :flash => {:alert => "You are not allowed to delete the User. Please contact System administrator."}
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    expire_data_after_sign_in!
    redirect_to new_registration_path(resource_name)
  end

  protected

  # By default we want to require a password checks on update.
  # You can overwrite this method in your own RegistrationsController.
  def update_resource(resource, params)
    resource.update_with_password(params)
  end

  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  def build_resource(hash = nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
  end

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  # The path used after sign up. You need to overwrite this method
  # in your own RegistrationsController.
  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end

  # The path used after sign up for inactive accounts. You need to overwrite
  # this method in your own RegistrationsController.
  def after_inactive_sign_up_path_for(resource)
    scope = Devise::Mapping.find_scope!(resource)
    router_name = Devise.mappings[scope].router_name
    context = router_name ? send(router_name) : self
    context.respond_to?(:root_path) ? context.root_path : "/"
  end

  # The default url to be used after updating a resource. You need to overwrite
  # this method in your own RegistrationsController.
  def after_update_path_for(resource)
    signed_in_root_path(resource)
  end

  # Authenticates the current scope and gets the current resource from the session.
  def authenticate_scope!
    send(:"authenticate_#{resource_name}!", force: true)
    self.resource = send(:"current_#{resource_name}")
  end

  def sign_up_params
    #devise_parameter_sanitizer.sanitize(:sign_up)
    params.require(:member).permit(:fname, :lname, :email, :password, :password_confirmation)
  end

  def account_update_params
    #devise_parameter_sanitizer.sanitize(:account_update)
    params.require(:member).permit(:fname, :lname, :email, :password, :password_confirmation, :current_password, :club_id, :position_id, :phone)
  end
end
