class Api::V1::PharmaciesController < Api::V1::ApplicationController
  prepend_before_action :authenticate_user_from_token!

  respond_to :json

  def index
    render :json => Pharmacy.all
  end
end
