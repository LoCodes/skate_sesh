class AddAccomplishedPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :accomplished, :string 
  end
end
