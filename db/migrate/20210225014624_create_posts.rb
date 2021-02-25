class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :trick_to_learn 
      t.text :description
      t.timestamps null: false
    end
  end
end
