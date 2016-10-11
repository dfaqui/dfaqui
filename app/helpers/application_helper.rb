module ApplicationHelper
  def current_channel
    request.fullpath.split('/')[1]
  end
end
