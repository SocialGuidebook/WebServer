class PostType < ActiveRecord::Base
  has_many :posts
  Text = find_by_name("Text")
  Photo = find_by_name("Photo")
  Album = find_by_name("Album")
  Video = find_by_name("Video")
  Link  = find_by_name("Link")
  Comment = find_by_name("Comment")
  Review  = find_by_name("Review")
  QA      = find_by_name("Q&A")
end
