class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: false do |t|
      t.uuid "id", default: "uuid_generate_v4()", primary_key: true
      t.text "user_name"
      t.text "first_name"
      t.text "last_name"
      t.text "email"
      t.text "password"
    end

    add_index :users, :user_name, unique: true
    add_index :users, :email, unique: true
  end
end
