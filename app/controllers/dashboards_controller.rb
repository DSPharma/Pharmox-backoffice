class DashboardsController < ApplicationController
  def index
    @campaigns = Campaign.all
    @challenges = Challenge.all
  end

  def campaigns_current
    @campaigns = Campaign.all
  end

  def challenges_current
    @challenges = Challenge.all
  end

  def campaigns_past
    @campaigns = Campaign.all
  end

  def challenges_past
    @challenges = Challenge.all
  end

  def campaigns_futur
    @campaigns = Campaign.all
  end

  def challenges_futur
    @challenges = Challenge.all
  end
end
