class CreateGifs < ActiveRecord::Migration
  def change
    create_table :gifs do |t|
      t.references :user, index: true
      t.string :title
      t.text :description
      t.integer :views

      t.timestamps null: false
    end
    add_foreign_key :gifs, :users
  end
end
