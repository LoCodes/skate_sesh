class CreateSkaters < ActiveRecord::Migration[5.2]
  def change
    create_table :skaters do |t| 
      t.string :username 
      t.string :password_digest
      t.string :location
    end 
  end
end
