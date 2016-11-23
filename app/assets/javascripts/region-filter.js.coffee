#= require filter

# element ids
@city_element       = get_element_id('city')
@group_element      = get_element_id('district-group')
@district_element   = get_element_id('district')
@block_element      = get_element_id('block')

# store select options
groups              = $(group_element).html()
districts           = $(district_element).html()
blocks              = $(block_element).html()

# event handlers
city_change_handler = (selected_value) ->
  set_options(selected_value, groups, group_element, 'Quadras')
  clear_options(district_element, 'Quadras / Nº')

  - if is_block_defined()
    clear_options(block_element, 'Bloco')

group_change_handler = (selected_value) ->
  set_options(selected_value, districts, district_element, 'Quadras / Nº')

  - if is_block_defined()
    clear_options(block_element, 'Bloco')

district_change_handler = (selected_value) ->
  set_options(selected_value, blocks, block_element, 'Bloco')

# change listeners
$(city_element).change ->
  selected_value = selected_item(city_element).text()
  city_change_handler(selected_value)

$(group_element).change ->
  selected_value = selected_item(group_element).text()
  group_change_handler(selected_value)

$(district_element).change ->
  - if is_block_defined()
    selected_value = selected_item(district_element).text()
    district_change_handler(selected_value)

is_block_defined = ->
  if blocks != '#undefined'
    true
  else
    false
