class EntriesController < ApplicationController
    def index
      @entries = Entry.all
    end

    def new
      @campaigns = Campaign.all
      @entries = Entry.all
      @entry = Entry.new
    end

    def show
      @entry = Entry.find(params[:id])
      if current_user.laboratory_id != @entry.laboratory_id
        redirect_to root_url, :flash => { :error => "Cette page n'exite pas." }
      end
    end

    def create
      @entry = Entry.new(entry_params)
        if @entry.save
              redirect_to new_entry_path, notice:"La saisie a été ajouté avec succès" #redirige vers la page de l’annonce et notifie l’utilisateur de la réussite de la création
        else
             render :new # s’il y a une erreur, redirige vers la page de création new
        end
    end

    def destroy
      Entry.find(params[:id]).destroy
      redirect_to new_entry_path, notice:"Saisie supprimer"
    end

private

    def set_entry
    end

    def entry_params
      params.require(:entry).permit(:type, :title, :product_concerned)
    end

end
