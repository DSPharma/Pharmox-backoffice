class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    verif = 0
    user = User.new(user_paramssignin)
    pharmacies = Pharmacy.all
    p params["user"]["enrollement_code"]
    pharmacies.each do |pharmacy|
      if params["user"]["enrollement_code"] === pharmacy.enrollement_code
        user.pharmacy_id = pharmacy.id
        verif = 1
      end
    end
    if verif === 0
        render :json => '{"error": "invalid email and password combination"}', :status => 500
        return
    end
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
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
