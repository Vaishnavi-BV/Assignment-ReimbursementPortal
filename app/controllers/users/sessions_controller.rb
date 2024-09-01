# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  def create
    self.resource = warden.authenticate!(auth_options)
    if resource
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      # Custom behavior when sign-in fails
      flash.now[:alert] = 'Invalid email or password'
      respond_with resource, location: new_session_path(resource_name)
    end
  end
end
