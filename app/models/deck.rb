class Deck < ApplicationRecord
  validates :name, :format, :user_id, presence: true

  belongs_to :user
  has_many :decklists, dependent: :destroy
  has_many :cards, through: :decklists
end
