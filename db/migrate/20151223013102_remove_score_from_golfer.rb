class RemoveScoreFromGolfer < ActiveRecord::Migration
  def change
    remove_column :golfers, :score, :string
  end
end
