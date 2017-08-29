class CardTypeController < ApplicationController
  def show
    @card_type = CardType.find(params[:id])
  end


end
