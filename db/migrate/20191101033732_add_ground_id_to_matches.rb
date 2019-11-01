class AddGroundIdToMatches < ActiveRecord::Migration[6.0]
  def change
    add_column :matches, :ground_id, :integer
  end
end
