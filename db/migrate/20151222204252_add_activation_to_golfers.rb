class AddActivationToGolfers < ActiveRecord::Migration
  def change
    add_column :golfers, :activation_digest, :string
    add_column :golfers, :activated,         :boolean, default: false
    add_column :golfers, :activated_at,      :datetime
  end
end
