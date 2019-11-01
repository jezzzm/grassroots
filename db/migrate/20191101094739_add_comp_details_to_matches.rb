class AddCompDetailsToMatches < ActiveRecord::Migration[6.0]
  def change
    add_column :matches, :age_group, :string
    add_column :matches, :division, :string
  end
end
