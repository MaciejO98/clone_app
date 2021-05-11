# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new
  end

  # POST /resource
  def create
    @user = User.new(user_params)
    if @user.save
        session[:user_id] = @user.id
        redirect_to root_path
    else
        render 'new'
    end
  end

  # GET /resource/edit
  def edit

  end

  # PUT /resource
  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  
    if @user.update(edit_user_params)
      flash[:notice] = "You have succesfully updated your profile"
      redirect_to root_path
    else
      render 'edit'
    end
  end

# Edycja użytkownika działa, ale nie musze podawać hasła żeby cokolwiek zmienić.

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def user_params
    params.require(:user).permit(:email, :First_name, :Last_name, :Year_of_birth, :password, :password_confirmation)
  end

  def edit_user_params
    params.require(:user).permit(:email, :First_name, :Last_name, :Year_of_birth, :password)
  end
end
