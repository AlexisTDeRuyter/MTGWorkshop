class Card < ApplicationRecord
  validates :card_type_id, :user_id, :quantity, presence: true

  belongs_to :card_type
  has_many :decklists
  has_many :decks, through: :decklists
  belongs_to :user

  scope :actual, ->{ where("quantity > 0") }
end
