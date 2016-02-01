class CreateGolfers < ActiveRecord::Migration
  def change
    create_table :golfers do |t|
      t.string :name
      t.string :score
      t.references :round, index: true

      t.timestamps null: false
    end
    add_foreign_key :golfers, :rounds
  end
end
