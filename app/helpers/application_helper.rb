module ApplicationHelper
  include Pagy::Frontend

  def selected x, y
    "selected" if x.to_s == y.to_s
  end
end
