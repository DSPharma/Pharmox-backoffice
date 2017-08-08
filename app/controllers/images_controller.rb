class ImagesController < ApplicationController

  def show
    @image = Image.find(params[:id])
  end

  def create
    @image = Image.new(image_params)
    if @image.save
      # @image.save_attachments(image_params) if params[:image][:picture]
      render :show, status: :created
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

private
  def image_params
    params.require(:image).permit(:name, :description, :image_base, :campaign_id, :entry_id)
  end
end
