class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :only_one_login

  protected

  def event
    # this should not really be hard coded.. but makes it a little easier during the initial implementation
    params[:event].presence || '2015'
  end

  def only_one_login
    if current_user && current_admin
      sign_out_all_scopes
      flash[:alert] = "You can only be logged in as a sign user type are any one time"
      redirect_to root_path(event: params[:event])
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end
end
