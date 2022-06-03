# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    admin_menus_path
  end

  def after_sign_out_path_for(resource)
    new_admin_session_path
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:email])
    devise_parameter_sanitizer.permit(:sign_in, keys:[:email])
  end

end
