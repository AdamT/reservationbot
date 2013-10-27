class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.datetime :time
      t.integer :group_size
      t.integer :table_id

      t.timestamps
    end

    add_index :reservations, :table_id
  end
end
