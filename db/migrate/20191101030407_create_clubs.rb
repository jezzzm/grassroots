class CreateClubs < ActiveRecord::Migration[6.0]
  def change
    create_table :clubs do |t|
      t.text :name
      t.string :short_sign
      t.text :website

      t.timestamps
    end
  end
end
