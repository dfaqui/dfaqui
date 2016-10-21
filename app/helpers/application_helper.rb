module ApplicationHelper
  def current_channel
    request.fullpath.gsub('?', '/').split('/')[1]
  end

  def navbar_channel_buttons
    navbar = brand_icon(current_channel)

    case current_channel
    when 'imoveis'
      navbar += channel_icon('comercio')
      navbar += channel_icon('delivery')
    when 'comercio'
      navbar += channel_icon('delivery')
      navbar += channel_icon('imoveis')
    when 'delivery'
      navbar += channel_icon('imoveis')
      navbar += channel_icon('comercio')
    end

    navbar
  end

  private

  def brand_icon(current_channel)
    link_to "/#{current_channel}" do
      content_tag(:div, class: 'image') do
        image_tag("#{current_channel}_brand.svg", class: 'brand-icon')
      end
    end
  end

  def channel_icon(channel)
    link_to "/#{channel}" do
      content_tag(:div, class: 'image') do
        image_tag("#{channel}_button.svg", class: 'channel-icon')
      end
    end
  end
end
