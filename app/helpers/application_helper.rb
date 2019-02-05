module ApplicationHelper
  include Pagy::Frontend

  def publish_or_draft p
    p == "published" ? "draft" : "published"
  end

  def label_publish_or_draft p
    p == "published" ? "success" : "default"
  end
  
  def selected x, y
    "selected" if x.to_s == y.to_s
  end

  def active_menu active_link
    controller_name == active_link ? 'active' : ''
  end
  
end
