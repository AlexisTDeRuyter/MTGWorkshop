class DecklistsController < ApplicationController
  def create
    @deck = Deck.find(params[:deck_id])
    card_type = CardType.find_or_query_for(params[:decklist][:card_name])
    if card_type.kind_of?(Integer)
      @main_errors = true
      @errors = ['Card could not be found']
      render 'decks/show', status: card_type and return
    end
    card = current_user.cards.find_by(card_type: card_type)
    if !card
      card = Card.create(user: current_user, card_type: card_type, quantity: 0)
    end
    decklist = Decklist.find_by(card: card, deck: @deck)
    if decklist
      if params[:decklist][:main] == 'true'
        new_quantity = decklist.amount_main + params[:decklist][:quantity].to_i
        decklist.update(amount_main: new_quantity)
      else
        new_quantity = decklist.amount_side + params[:decklist][:quantity].to_i
        decklist.update(amount_side: new_quantity)
      end
    else
      if params[:decklist][:main] == 'true'
        decklist = Decklist.create(card: card, deck: @deck, amount_main: params[:decklist][:quantity])
      else
        decklist = Decklist.create(card: card, deck: @deck, amount_side: params[:decklist][:quantity])
      end
    end
    if decklist.save
      redirect_to deck_path(@deck)
    else
      @main_errors = true
      @errors = card_deck.errors.full_messages
      render 'decks/show'
    end
  end

  def destroy

  end
end
