class AddPasswordDigestToGolfers < ActiveRecord::Migration
  def change
    add_column :golfers, :password_digest, :string
  end
end
