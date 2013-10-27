class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.datetime :time
      t.integer :group_size
      t.references :table

      t.timestamps
    end
  end
end
