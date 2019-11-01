class CreateTeamsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :teams_users, :id => false do |t|
      t.integer :fav_team_id
      t.integer :user_id
    end
  end
end
