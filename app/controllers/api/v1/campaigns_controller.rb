class Api::V1::CampaignsController < Api::V1::ApplicationController
  # prepend_before_action :authenticate_user!
  prepend_before_action :authenticate_user_from_token!
  # prepend_before_action :require_no_authentication

  respond_to :json

  def index
    campaigns = Campaign.where(pharmacy_id: params["user"]["pharmacy_id"])
    now = campaigns.where("start_at <= ?", Time.zone.now.beginning_of_day)
    @now = now.where("end_at >= ?", Time.zone.now.beginning_of_day)
    @now_nbr = @now.count
    @past = campaigns.where("end_at <= ?", Time.zone.now.beginning_of_day)
    @past_nbr = @past.count
    @futur = campaigns.where("start_at > ?", Time.zone.now.beginning_of_day)
    @futur_nbr = @futur.count
    render :json => { now_nbr: @now_nbr, now: @now, past_nbr: @past_nbr, past: @past, futur_nbr: @futur_nbr, futur: @futur }, :status => 200
  end

  def show
    if params[:time] == "now"
      render :json => @now, :status => 200
    elsif params[:time] == "past"
      render :json => @past, :status => 200
    elsif params[:time] == "futur"
      render :json => @futur, :status => 200
    end
  end

  def create
  end
end
