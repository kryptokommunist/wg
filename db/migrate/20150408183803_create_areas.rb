class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.boolean :clean
      t.datetime :last_cleaned
      t.integer :points

      t.timestamps null: false
    end
  end
end
