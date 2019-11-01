class FixColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :teams_users, :fav_team_id, :team_id
  end
end
