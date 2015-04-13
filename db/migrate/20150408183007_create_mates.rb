class CreateMates < ActiveRecord::Migration
  def change
    create_table :mates do |t|
      t.string :first_name
      t.string :last_name
      t.string :mobile_number
      t.string :email
      t.integer :points
      t.integer :balance

      t.timestamps null: false
    end
  end
end
