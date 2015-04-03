class Watched < ActiveRecord::Base
  belongs_to :user
  belongs_to :gif
end
