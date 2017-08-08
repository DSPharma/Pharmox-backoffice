class Api::V1::ImagesController < Api::V1::ApplicationController

  def create
    @image = Image.new(image_params)
    if @image.save
      # @image.save_attachments(image_params) if params[:image][:picture]
      p @image
      render :show, status: :created, location: @image
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  def image_params
    params.require(:image).permit(:name, :description, :image_base)
  end
end
