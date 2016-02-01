class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :par
      t.string :par_data

      t.timestamps null: false
    end
  end
end
