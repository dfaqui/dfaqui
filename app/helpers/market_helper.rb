module MarketHelper
  def link_button(zipcode)
    if current_channel == 'comercio'
      label = 'DELIVERY'
      path  = list_deliveries_path(cep: zipcode)
      color = 'delivery-button'
    elsif current_channel == 'delivery'
      label = 'COMÉRCIO'
      path  = list_markets_path(cep: zipcode)
      color = 'market-button'
    end

    link_to(label, path, class: "ui tiny #{color} button")
  end

  def open_label(market)
    is_open       = market.is_open?
    color, label  = is_open ? ['green', 'Aberto'] : ['red', 'Fechado']

    content = content_tag(:div, nil, class: ['ui', "#{color}", 'empty', 'circular', 'label'])
    content << " #{label}"
  end

  def tags(market)
    html = ''

    if market.specialities.any?
      tags = market.specialities.pluck(:name)

      tags.each do |tag|
        html += content_tag(:a, class: 'ui label') do
          content_tag(:i, nil, class: 'tag icon') + tag
        end
      end
    end

    html.html_safe
  end

  def price_category(value, fill_color='yellow', unfill_color='grey')
    html = ''

    if value
      5.times do |i|
        color = (value > i) ? fill_color : unfill_color
        html += content_tag(:i, nil, class: "#{color} dollar fitted icon")
      end
    end

    html.html_safe
  end
end
