class AddAttachmentGifToGifs < ActiveRecord::Migration
  def change
    add_attachment :gifs, :gif
  end
end
