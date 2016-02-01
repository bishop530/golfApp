class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.string :score
      t.references :round, index: true
      t.references :golfer, index: true

      t.timestamps null: false
    end
    add_foreign_key :scores, :rounds
    add_foreign_key :scores, :golfers
  end
end
