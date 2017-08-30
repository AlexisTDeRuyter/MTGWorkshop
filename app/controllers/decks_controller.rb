class DecksController < ApplicationController
  before_action :authenticate_user!

  def create
    deck = Deck.new(deck_params)
    deck.user = current_user
    if deck.save
      redirect_to profile_path
    else
      @deck_errors = true
      @errors = deck.errors.full_messages
      render 'users/show'
    end
  end

  def show
    @deck = Deck.find(params[:id])
  end

  def destroy
    Deck.find(params[:id]).destroy
    redirect_to profile_path
  end

  private
    def deck_params
      params.require(:deck).permit(:name, :format)
    end
end
