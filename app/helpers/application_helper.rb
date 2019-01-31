module ApplicationHelper
  include Pagy::Frontend

  def publish_or_draft p
    p == "published" ? "draft" : "published"
  end

  def selected x, y
    "selected" if x.to_s == y.to_s
  end

  def current_class?(test_path)
      request.path == test_path ? 'active' : ''
  end

end
