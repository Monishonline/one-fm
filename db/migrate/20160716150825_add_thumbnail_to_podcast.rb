class AddThumbnailToPodcast < ActiveRecord::Migration
  def change
    add_column :podcasts, :thumbnail, :string
  end
end
