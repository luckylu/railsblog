class RemoveAdminIdFromComment < ActiveRecord::Migration
  def change
    remove_column :comments, :admin_id, :integer
  end
end
