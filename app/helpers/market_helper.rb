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
end
