module ApplicationHelper
  include Pagy::Frontend

  def publish_or_draft p
    p == "published" ? "draft" : "published"
  end

  def label_publish_or_draft p
    p == "published" ? "success" : "default"
  end

  def status_cluster s
    case s
    when "approved"
      "success"
    when "requested"
      "default"
    when "rejected"
      "danger"
    end
  end
  
  def selected x, y
    "selected" if x.to_s == y.to_s
  end

  def active_menu active_link
    if active_link.is_a? Array
      controller_name.in?(active_link) ? 'active' : ''
    else
      controller_name == active_link ? 'active' : ''
    end
  end
  
  def active_menu_parent controllers
    controller_name.in?(controllers) ? 'in' : 'out'
  end

  def collapse_in_if q
    result = 'out'
    q.each do |p|
      result = params[p.to_s].present? ? 'in' : 'out'
    end
    result
  end
  
  

end
