#= require filter

# element ids
@city_element      = get_element_id('city')
@group_element     = get_element_id('district-group')
@district_element  = get_element_id('district')

# store select options
groups            = $(group_element).html()
districts         = $(district_element).html()

# event handlers
city_change_handler = (selected_value) ->
  set_options(selected_value, groups, group_element, 'Quadras')
  clear_options(district_element, 'Quadra')

group_change_handler = (selected_value) ->
  set_options(selected_value, districts, district_element, 'Quadra')

# change listeners
$(city_element).change ->
  selected_value = selected_item(city_element).text()
  city_change_handler(selected_value)

$(group_element).change ->
  selected_value = selected_item(group_element).text()
  group_change_handler(selected_value)
