class PharmaciesController < ApplicationController
    def index
      # @pharmacies = Pharmacy.all

    end

    def new
       @pharmacy = Pharmacy.new
    end

    def create
      @pharmacy = Pharmacy.new(pharmacy_params)
        if @pharmacy.save
              redirect_to root_path, notice:"La pharmacy a été ajouté avec succès" #redirige vers la page de l’annonce et notifie l’utilisateur de la réussite de la création
        else
             render :new # s’il y a une erreur, redirige vers la page de création new
        end
    end

    def import
      Pharmacy.import(params[:file])
      redirect_to root_url, notice: "Pharmacies importées."
    end

    def api
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

private

    def set_pharmacy

    end

    def pharmacy_params
      params.require(:pharmacy).permit(:name, :product, :start_at, :end_at, :target, :nbr_pharma, :laboratory_id)
    end

end
