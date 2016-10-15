#= require filter

# element ids
@size_element             = '#size-filter'
@rooms_element            = '#quartos'
@area_element             = '#area'

@situation_element        = get_element_id('situation')
@type_element             = get_element_id('type')

# event handlers
set_filter_element = (selected_value) ->
  if selected_value
    if selected_value == 'residential'
      name    = 'quartos'
      options = show_rooms_filter()
    else if selected_value == 'commercial'
      name    = 'area'
      options = show_area_filter()
  else
    name    = ''
    options = default_option('Selecione')

  set_filter_options(name, options)

# util functions
set_filter_options = (name, options) ->
  $(size_element).attr('name', name);
  $(size_element).find('option').remove().end().append(options)

# change listeners
$(type_element).change ->
  selected_value = selected_item(type_element).val()
  set_filter_element(selected_value)

show_rooms_filter = ->
  '<option value="">Número de quartos</option>' +
  '<option value="1">1</option>' +
  '<option value="2">2</option>' +
  '<option value="3">3</option>' +
  '<option value="4_100">4 ou mais</option>'

show_area_filter = ->
  '<option value="">Área (m²)</option>' +
  '<option value="0_50">0 - 50</option>' +
  '<option value="51_70">51 - 70</option>' +
  '<option value="71_100">71 - 100</option>' +
  '<option value="100_1000000">100 ou mais</option>'
