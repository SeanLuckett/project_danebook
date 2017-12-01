module ApplicationHelper
  def active_nav_item_if(path)
    'active' if current_page?(path)
  end
end
