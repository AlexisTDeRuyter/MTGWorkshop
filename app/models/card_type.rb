class CardType < ApplicationRecord
  validates :scryfall_id, :name, :data, presence: true
  validates :scryfall_id, :name, uniqueness: true

  has_many :cards

  def self.find_or_query_for(name)
    card_type = self.where("name ILIKE ?", "%#{name}%").first
    card_type ? card_type : self.query_for(name)
  end

  private

  def self.query_for(name)
    begin
      response = RestClient.get('https://api.scryfall.com/cards/named', params: {fuzzy: name})
      parsed_response = JSON.parse(response.body)
      card_type = self.create!(scryfall_id: parsed_response['id'], name: parsed_response['name'], data: parsed_response)
    rescue RestClient::ExceptionWithResponse => error
      error.response.code
    end
  end
end
