class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.integer :seats

      t.timestamps
    end
  end
end
