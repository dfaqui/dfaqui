#= require filter

# element ids
@segment_element    = get_element_id('segment')
@category_element   = get_element_id('category')
@speciality_element = get_element_id('speciality')

# store select options
categories          = $(category_element).html()
specialities        = $(speciality_element).html()

# event handlers
segment_change_handler = (selected_value) ->
  set_options(selected_value, categories, category_element, 'Tipo')
  clear_options(speciality_element, 'Especialidade')

category_change_handler = (selected_value) ->
  set_options(selected_value, specialities, speciality_element, 'Especialidade')

# change listeners
$(segment_element).change ->
  selected_value = selected_item(segment_element).text()
  segment_change_handler(selected_value)

$(category_element).change ->
  selected_value = selected_item(category_element).text()
  category_change_handler(selected_value)
