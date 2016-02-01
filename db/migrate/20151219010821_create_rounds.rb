class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.datetime :date
      t.references :course, index: true

      t.timestamps null: false
    end
    add_foreign_key :rounds, :courses
  end
end
