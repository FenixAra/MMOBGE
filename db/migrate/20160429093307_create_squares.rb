class CreateSquares < ActiveRecord::Migration
  def change
    create_table :squares do |t|
      t.text :name
      t.integer :board_id
      t.text :state

      t.timestamps null: false
    end
  end
end
