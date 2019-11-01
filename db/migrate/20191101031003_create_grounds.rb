class CreateGrounds < ActiveRecord::Migration[6.0]
  def change
    create_table :grounds do |t|
      t.text :name
      t.string :short_sign
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
