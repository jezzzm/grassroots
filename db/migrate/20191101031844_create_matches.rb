class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.integer :round
      t.datetime :game_date
      t.integer :home_score
      t.integer :away_score
      t.text :comments

      t.timestamps
    end
  end
end
