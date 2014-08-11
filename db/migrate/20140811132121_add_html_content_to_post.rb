class AddHtmlContentToPost < ActiveRecord::Migration
  def change
    add_column :posts, :html_content, :text
  end
end
