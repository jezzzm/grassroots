class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :identifier
      t.string :age_group
      t.string :division

      t.timestamps
    end
  end
end
