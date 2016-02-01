class AddResetSentAtToGolfers < ActiveRecord::Migration
  def change
    add_column :golfers, :reset_sent_at, :datetime
  end
end
