class AddSkaterIdToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :skater_id, :integer
  end
end
