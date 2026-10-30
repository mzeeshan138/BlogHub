module ApplicationHelper
  def admin_area?
    user_signed_in? && current_user.admin? && request.path.start_with?("/admin")
  end

  def publication_status(post)
    t(post.published? ? "posts.status.published" : "posts.status.draft")
  end

  def flash_class(level)
    case level.to_s
    when "notice" then "success"
    when "alert" then "danger"
    else "info"
    end
  end
end
