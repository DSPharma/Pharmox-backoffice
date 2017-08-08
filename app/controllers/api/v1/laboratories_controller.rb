class Api::V1::LaboratoriesController < Api::V1::ApplicationController
  prepend_before_action :authenticate_user_from_token!

  respond_to :json

  def index
    laboratories = Laboratory.all
    render :json => laboratories, :status => 200
  end
end
