class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.text :name
      t.string :users
      t.integer :rows
      t.integer :column

      t.timestamps null: false
    end
  end
end
