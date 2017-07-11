class LaboratoriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index

  end

  def new
     @laboratory = Laboratory.new
  end

  def create
    @laboratory = Laboratory.new(laboratory_params)
      if @laboratory.save
            redirect_to root_path, notice:"L'entreprise a été ajouté avec succès" #redirige vers la page de l’annonce et notifie l’utilisateur de la réussite de la création
      else
           render :new # s’il y a une erreur, redirige vers la page de création new
      end
  end

  def edit

  end

  def update

  end

private
  def set_laboratory

  end

  def laboratory_params
    params.require(:laboratory).permit(:name)
  end

end
