class Api::CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.all
    render json: @campaigns, status: :ok
  end

  def show
    @campaign = Campaign.find(params[:id])
    render json: @campaign
  end

  def create
    @campaign = Campaign.new(campaign_params)

    if @campaign.save
      render json: {message: "Campaign have been successfully created."}, status: :created
    else
      render error:{error: "sorry Campaign is not created"}, status:404 
    end
  end

  def update
    @campaign = Campaign.find(params[:id])

    if @campaign
      @campaign.update(campaign_params)
      render json: {message: "Campaign have been successfully Updated."}, status: :accepted
    else
      render error: {error: "Campaign havn't Update."}, status:406
    end
  end

  def destroy
    @campaign = Campaign.find(params[:id])
    if @campaign.destroy
      render json: {message: "Campaign have Destroyed"}, status: :accepted
    else
      render error:{error: "Campaign havn't destroy"}, status:406
    end
  end

  private

  def campaign_params
    params.require(:campaign).permit(:title, :purpose, :estimated_duration)
  end
end
