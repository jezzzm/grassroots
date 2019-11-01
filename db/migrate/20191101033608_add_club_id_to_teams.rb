class AddClubIdToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :club_id, :integer
  end
end
