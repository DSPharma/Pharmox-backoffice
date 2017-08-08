require 'zip/zip'

class CampaignsController < ApplicationController

    def index
      # @campaigns = Campaign.all
      p 'index '*10
      p session[:nbr_campaign]
      # path = Campaign.where(campaign_number: session[:nbr_campaign])
      @campaigns = Campaign.where(campaign_number: session[:nbr_campaign])
      respond_to do |format|
        format.html
        format.xlsx {
          response.headers['Content-Disposition'] = 'attachment; filename="all_products.xlsx"'
        }
      end
      @campaign = @campaigns.first
    end

    def product
      session[:nbr_campaign] = params[:data]
      # $product = params[:data]
      p "le produit"
      p session[:nbr_campaign]
      # p @product
    end

    def new
       @campaign = Campaign.new
    end

    def show
      p params
      @campaign = Campaign.find(params[:id])
      @entries = Entry.where(num_campaign: @campaign.campaign_number)
      @images = Image.where(campaign_id: params[:id])
      @inputs = Input.where(campaign_id: params[:id])
      @campaigns = Campaign.where(campaign_number: @campaign.campaign_number)
      if current_user.admin == false
        if current_user.laboratory_id != @campaign.laboratory_id
          redirect_to root_url, :flash => { :error => "Cette page n'exite pas." }
        end
      end
    end

    def create
      @campaign = Campaign.new(campaign_params)
        if @campaign.save
            redirect_to root_path, notice:"La campagne a été ajouté avec succès" #redirige vers la page de l’annonce et notifie l’utilisateur de la réussite de la création
        else
            render :new # s’il y a une erreur, redirige vers la page de création new
        end
    end

    def update
      @campaign = Campaign.find(params[:id])
      if params[:statut] === "validate"
        @campaign.update_attribute("statut_type", 'validate')
        redirect_to campaign_path(@campaign)
      elsif params[:statut] === "rejected"
        @campaign.update_attribute("statut_type", 'rejected')
        redirect_to campaign_path(@campaign)
      end
    end

    def import
      p params[:product]
      Campaign.import(params[:file], Pharmacy.all, params[:title], params[:product], params[:start_at], params[:end_at], params[:target], params[:laboratory_id])
      redirect_to root_url, notice: "Campagne importée."
    end

    def accepte
      @campaign = Campaign.find(params[:id])
      if @campaign.update_attribute("statut_type", 'validate')
        redirect_to campaign_path(@campaign)
      end
    end

private

    def set_campaign

    end

    def campaign_params
      params.require(:campaign).permit(:title, :product, :start_at, :end_at, :target, :nbr_pharma, :laboratory_id, :statut_type)
    end

end
