class CreateWatcheds < ActiveRecord::Migration
  def change
    create_table :watcheds do |t|
      t.references :user, index: true
      t.references :gif, index: true

      t.timestamps null: false
    end
    add_foreign_key :watcheds, :users
    add_foreign_key :watcheds, :gifs
  end
end
