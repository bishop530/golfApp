class RemoveRoundFromGolfer < ActiveRecord::Migration
  def change
    remove_reference :golfers, :round, index: true
    remove_foreign_key :golfers, :rounds
  end
end
