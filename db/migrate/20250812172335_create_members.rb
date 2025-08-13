class CreateMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :members do |t|
      t.string  :name, null: false
      t.string  :surname, null: false
      t.string  :email, null: false, index: { unique: true }
      t.date    :birthday, null: false
      t.integer :number_of_club_games_played, null: false, default: 0
      t.integer  :current_rank, null: false
      t.timestamps
    end
  end
end
