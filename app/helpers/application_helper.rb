module ApplicationHelper
  def current_channel
    request.fullpath.gsub('?', '/').split('/')[1]
  end
end
