class Api::CommentsController < ApplicationController
  before_action :set_campaign
  
  def index
    @comments = @campaign.comments.all
    render json: @comments, status: :ok
  end

  def show
    @comment = Comment.find(params[:id])
    render json: @comment
  end

  def create
    #debugger
    @comment = @campaign.comments.create(comment_params)

    if @comment.save!
      render json: {message: "Comment for campaign have been successfully created."}, status: :created
    else
      render error:{error: "sorry comment for Campaign is not created"}, status:404 
    end
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment
      @comment.update(comment_params)
      render json: {message: "comment for Campaign have been successfully Updated."}, status: :accepted
    else
      render error: {error: "comment for Campaign havn't Update."}, status:406
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      render json: {message: "comment for Campaign have Destroyed"}, status: :accepted
    else
      render error:{error: "comment for Campaign havn't destroy"}, status:406
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :campaign_id)
  end

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end
end
