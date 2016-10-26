module ApplicationHelper
  def current_channel
    channel = request.fullpath.gsub('?', '/').split('/')[1]
    channel = ['comercio', 'delivery', 'imoveis'].include?(channel) ? channel : nil
  end

  def navbar_channel_buttons
    if current_channel
      navbar = brand_icon(current_channel)

      case current_channel
      when 'imoveis'
        navbar += channel_icon('imoveis')
        navbar += channel_icon('comercio')
        navbar += channel_icon('delivery')
      when 'comercio'
        navbar += channel_icon('comercio')
        navbar += channel_icon('delivery')
        navbar += channel_icon('imoveis')
      when 'delivery'
        navbar += channel_icon('delivery')
        navbar += channel_icon('imoveis')
        navbar += channel_icon('comercio')
      end
    else
      navbar = brand_icon('dfaqui')
    end

    navbar
  end

  private

  def brand_icon(channel)
    link_to root_path do
      content_tag(:div, class: 'image') do
        image_tag("#{channel}_brand.svg", class: 'brand-icon')
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
