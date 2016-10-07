module PropertyHelper
  def commercial_situation(situation)
    color = { release: 'purple', sale: 'orange', rent: 'teal' }
    color[situation.to_sym]
  end

  def render_tab_items(selected_tab, has_tour)
    tab_count     = has_tour ? 'two' : 'one'
    gallery_class = ['item']
    tour_class    = ['item']

    if selected_tab.nil? || selected_tab == 'galeria' || (selected_tab == 'tour' && !has_tour)
      gallery_class << 'active'
    elsif selected_tab == 'tour' && has_tour
      tour_class << 'active'
    end

    content_tag(:div, class: "ui #{tab_count} item pointing menu") do
      concat link_to 'Ver fotos', property_show_path(tab: 'galeria'), class: gallery_class

      if has_tour
        concat ' '
        concat link_to 'Tour virtual', property_show_path(tab: 'tour'), class: tour_class
      end
    end
  end

  def render_tab_content(selected_tab, has_tour)
    partial = 'gallery'

    if selected_tab.nil? || selected_tab == 'galeria'
      partial = 'gallery'
    elsif selected_tab == 'tour' && has_tour
      partial = 'tour'
    end

    render partial: partial
  end
end
