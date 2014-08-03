class RemoveAdminIdFromPost < ActiveRecord::Migration
  def change
    remove_column :posts, :admin_id, :integer
  end
end
