class CreateDuties < ActiveRecord::Migration
  def change
    create_table :duties do |t|
      t.string :name
      t.integer :experience_id

      t.timestamps null: false
    end
  end
end
