class CreateGifTags < ActiveRecord::Migration
  def change
    create_table :gif_tags do |t|
      t.references :gif, index: true
      t.references :tag, index: true

      t.timestamps null: false
    end
    add_foreign_key :gif_tags, :gifs
    add_foreign_key :gif_tags, :tags
  end
end
