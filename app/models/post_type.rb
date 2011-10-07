class PostType < ActiveRecord::Base
  has_many :posts
  Text = find_by_name("Text")
  Photo = find_by_name("Photo")
  Album = find_by_name("Album")
  Video = find_by_name("Video")
  Comment = find_by_name("Comment")
end
