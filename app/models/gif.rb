class Gif < ActiveRecord::Base
  belongs_to :user
  has_many :gif_tags, dependent: :destroy
  has_many :tags, :through => :gif_tags
  has_many :watcheds, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :watchers, :through => :watcheds, :source => :user
  has_many :user_comments, :through => :comments, :source => :user
  has_attached_file :gif,
                  :url => "/assets/:class/:id/:attachment/:style.:extension",
                  :path => ":rails_root/public/assets/:class/:id/:attachment/:style.:extension"
  validates_attachment_content_type :gif, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_presence_of :gif
  validates_presence_of :title
  
  def num_likes
	self.likes.where(updown: 1).count
  end
  
  def num_dislikes
	self.likes.where(updown: -1).count
  end
end
