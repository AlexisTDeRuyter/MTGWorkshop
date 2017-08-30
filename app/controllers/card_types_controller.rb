class CardTypesController < ApplicationController
  def show
    @card_type = CardType.find(params[:id])
  end
end
