class CreateDeckLists < ActiveRecord::Migration[5.1]
  def change
    create_table :deck_lists do |t|
      t.integer :card_id, null: false
      t.integer :deck_id, null: false
      t.integer :amount_main, null: false, default: 0
      t.integer :amount_side, null: false, default: 0

      t.timestamps
    end
  end
end
