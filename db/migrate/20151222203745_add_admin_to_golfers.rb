class AddAdminToGolfers < ActiveRecord::Migration
  def change
    add_column :golfers, :admin, :boolean, default: false
  end
end
