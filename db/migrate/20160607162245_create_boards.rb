class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards, id: false do |t|
      t.uuid "id", default: "uuid_generate_v4()", primary_key: true
      
    end
  end
end
