class CreateUuidExtension < ActiveRecord::Migration
  def up
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";"
  end
end
