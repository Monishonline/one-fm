class Episode < ActiveRecord::Base
  belongs_to :podcast

 mount_uploader :avatar, ThumbnailUploader
end
