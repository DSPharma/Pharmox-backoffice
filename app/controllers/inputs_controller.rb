class InputsController < ApplicationController

  def show
    @input = Input.find(params[:id])
  end

  def create
    @input = Input.new(input_params)
    if @input.save
      # @input.save_attachments(input_params) if params[:input][:picture]
      render status: 200
    else
      render json: @input.errors, status: :unprocessable_entity
    end
  end

  def input_params
    params.require(:input).permit(:value, :campaign_id, :entry_id)
  end
end
