class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards, id: false do |t|
      t.uuid "id", default: "uuid_generate_v4()", primary_key: true
      t.text "users", array: true
      t.uuid "client_id"
      t.integer "rows"
      t.integer "columns"
      t.json "records"
    end
  end
end
