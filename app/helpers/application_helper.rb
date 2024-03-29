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

  def render_banner
    if current_channel == 'imoveis'
      city              = (params[:cidade].present?) ? params[:cidade] : City.select(:slug).first.slug
      background_image  = Page.get_value('property-banner', city)
    else
      background_image  = image_url "#{current_channel}_banner.png"
    end

    html = content_tag(
      :div,
      nil,
      class: 'channel-banner',
      style: "background-image: url(#{background_image})"
    )

    if browser.device.mobile?
      html += link_to favorites_path do
        image_tag 'favorite_button.svg', class: 'favorite-button'
      end
    end

    html
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

  def status_icon(status)
    if [true, 1].include? status
      status = :true
    elsif [false, 0].include? status
      status = :false
    end

    icons = {
      true: {icon: 'checkmark', color: 'green'},
      false: {icon: 'remove', color: 'red'}
    }

    content_tag(:i, nil, class: "#{icons[status][:color]} #{icons[status][:icon]} icon")
  end

  def channel_color_class
    color_class = ''

    case current_channel
      when 'comercio' then color_class = 'market-color'
      when 'delivery' then color_class = 'delivery-color'
      when 'imoveis'  then color_class = 'property-color'
    end

    color_class
  end
end
