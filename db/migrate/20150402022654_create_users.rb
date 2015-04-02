class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :password
      t.string :salt

      t.timestamps null: false
    end
  end
end
