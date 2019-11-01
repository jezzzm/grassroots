class AddTeamIdToMatches < ActiveRecord::Migration[6.0]
  def change
    add_column :matches, :home_id, :integer
    add_column :matches, :away_id, :integer
  end
end
