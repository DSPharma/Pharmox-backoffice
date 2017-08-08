class Api::V1::PharmaciesController < Api::V1::ApplicationController
  respond_to :json

  def index
    pharmacies = Pharmacy.all
    email = nil
    pharmacies.each do |pharmacy|
      if (params[:cip].to_i == pharmacy.cip)
        id = pharmacy.id
        email = Email.where(pharmacy_id: id)
      end
    end
    p email[0].email
    if email
      render :json => email[0].email, :status => 200
      return
    end
    render :status => 422
  end
end
