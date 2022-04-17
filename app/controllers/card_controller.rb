class CardController < ApplicationController

  def new
    @card = Card.new
    @list = List.find_by(id:params[:list_id])
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to root_url
    else
      render action:new
    end
  end

  def show
    @card = Card.find_by(id:params[:id])
  end

  def edit
    @card = Card.find_by(id:params[:id])
    @lists = List.where(user: current_user)
  end

  def update
    @card = Card.find_by(id:params[:id])
    @lists = List.where(user: current_user)
    if @card.update(card_params)
    redirect_to root_url
    else
    flash[:alert] = "you failed to update"
    render action: :edit
    end
  end

  def destroy
    @card = Card.find_by(id:params[:id])
    @card.destroy
    redirect_to root_url
  end

  private
  def card_params
    params.require(:card).permit(:title,:memo,:list_id)
  end
end
