class CreateFavTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :favs do |t|
      t.references :team, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :name

      t.timestamps
    end
  end
end
