class CreateBoardUsers < ActiveRecord::Migration
  def change
    
    create_table :board_users, id: false do |t|
      t.uuid "id", default: "uuid_generate_v4()", primary_key: true
      t.uuid "board_id"
      t.uuid "user_id"
    end

    add_index :board_users, [:board_id, :user_id], unique: true
    execute "ALTER TABLE board_users ADD CONSTRAINT fk_board_users_board_id FOREIGN KEY (board_id) REFERENCES boards(id)"
    execute "ALTER TABLE board_users ADD CONSTRAINT fk_board_users_user_id FOREIGN KEY (user_id) REFERENCES users(id)"
  end
end
