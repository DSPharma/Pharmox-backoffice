class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    user = User.new(user_paramssignin)
    if user.save
      render :json => user.as_json(:auth_token=>user.authentication_token, :email => user.email ), :status=>201
      return
    else
      warden.custom_failure!
      render :json => user.errors, :status=>422
    end
  end

  private

  def user_paramssignin
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role, :laboratory_id)
  end
end
