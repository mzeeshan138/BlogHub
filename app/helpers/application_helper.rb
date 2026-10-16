module ApplicationHelper
  def publication_status(post)
    t(post.published? ? "posts.status.published" : "posts.status.draft")
  end
end
