class AddResetToGolfers < ActiveRecord::Migration
  def change
    add_column :golfers, :reset_digest, :string
  end
end
