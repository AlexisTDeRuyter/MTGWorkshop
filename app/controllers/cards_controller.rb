class CardsController < ApplicationController
  def create
    cardtype = CardType.find_or_query_for(params[:name])
    if cardtype.kind_of?(Integer)
      @card_errors = true
      @errors = ['Card could not be found']
      render 'users/show', status: cardtype and return
    end
    card = Card.where(card_type: cardtype)
    if card.any?
      card.first.quantity += params[:quantity].to_i
      card.first.save
      redirect_to profile_path
    else
      card = Card.new(card_type: cardtype, quantity: params[:quantity], user: current_user)
      if card.save
        redirect_to profile_path
      else
        @card_errors = true
        @errors = card.errors.full_messages
        render 'users/show'
      end
    end
  end

  def destroy
    Card.find(params[:id]).destroy
    redirect_to profile_path
  end
end
