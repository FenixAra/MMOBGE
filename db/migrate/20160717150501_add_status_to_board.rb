class AddStatusToBoard < ActiveRecord::Migration
  def change
    add_column :boards, :status, :text

    add_index :boards, :status
  end
end
