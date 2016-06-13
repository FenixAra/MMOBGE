class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients, id: false do |t|
      t.uuid "id", default: "uuid_generate_v4()", primary_key: true
      t.text "name"
    end

    execute "INSERT INTO clients(name) VALUES('tic-tac-toe')"
    execute "ALTER TABLE boards ADD CONSTRAINT fk_client_id FOREIGN KEY (client_id) REFERENCES clients(id)"
  end
end
