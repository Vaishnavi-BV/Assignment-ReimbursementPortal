class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    puts 'Permitted parameters.......'
    devise_parameter_sanitizer.permit(
      :sign_up, keys: [:first_name, :last_name, :email, :password, :role, :designation, :department_id]
    )
    devise_parameter_sanitizer.permit(
      :account_update, keys: %i[first_name last_name email password current_password role designation department_id]
    )
  end
end
