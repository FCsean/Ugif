class Gif < ActiveRecord::Base
  belongs_to :user
  has_many :gif_tags
  has_many :tags, :through => :gif_tags
  has_many :watcheds
  has_many :comments
  has_many :watchers, :through => :watcheds, :source => :user
  has_many :user_comments, :through => :comments, :source => :user
  has_attached_file :gif,
                  :url => "/assets/:class/:id/:attachment/:style.:extension",
                  :path => ":rails_root/public/assets/:class/:id/:attachment/:style.:extension"
  validates_attachment_content_type :gif, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_presence_of :gif
  validates_presence_of :title
end
