class CreateMatches < ActiveRecord::Migration[8.0]
  def change
    create_table :matches do |t|
      t.references :player_one, null: false
      t.references :player_two, null: false
      t.integer :winner_id
      t.timestamps
    end

    add_foreign_key :matches, :members, column: :player_one_id
    add_foreign_key :matches, :members, column: :player_two_id
    add_foreign_key :matches, :members, column: :winner_id
  end
end
