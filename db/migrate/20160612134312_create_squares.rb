class CreateSquares < ActiveRecord::Migration
  def change
    create_table :squares, id: false do |t|
      t.uuid "id", default: "uuid_generate_v4()", primary_key: true
      t.uuid "board_id"
      t.integer "i"
      t.integer "j"
      t.text "name", default: ""
      t.json "state"
    end

    add_index :squares, [:board_id, :i, :j]
    execute "ALTER TABLE squares ADD CONSTRAINT fk_board_id FOREIGN KEY (board_id) REFERENCES boards(id)"
  end
end
