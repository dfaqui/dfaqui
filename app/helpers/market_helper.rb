module MarketHelper
  def link_button(zipcode)
    if current_channel == 'comercio'
      label = 'DELIVERY'
      path  = list_deliveries_path(cep: zipcode)
      color = 'delivery-color'
    elsif current_channel == 'delivery'
      label = 'COMÉRCIO'
      path  = list_markets_path(cep: zipcode)
      color = 'market-color'
    end

    link_to(label, path, class: "ui small #{color} button")
  end

  def open_label(market)
    is_open       = market.is_open?
    color, label  = is_open ? ['green', 'Aberto'] : ['red', 'Fechado']

    content = content_tag(:div, nil, class: ['ui', "#{color}", 'empty', 'circular', 'label'])
    content << " #{label}"
  end
end
