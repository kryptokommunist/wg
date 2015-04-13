class CreateDuties < ActiveRecord::Migration
  def change
    create_table :duties do |t|
      t.belongs_to :mate
      t.belongs_to :area
      t.datetime :due_to
      t.datetime :accomplished_at
      t.boolean :accomplished_by_assigned
      t.boolean :faulty

      t.timestamps null: false
    end
  end
end
