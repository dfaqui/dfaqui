get_element_id = (data_name) ->
  result = $("[data-#{data_name}]").data("#{data_name}")
  "##{result}"

selected_item = (element) ->
  $("#{element} :selected")

default_option = (label) ->
  "<option value=''>#{label}</option>"

set_options = (optiongroup, options, target, label) ->
  result = default_option(label)
  result += $(options).filter("optgroup[label='#{optiongroup}']").html()

  $(target).html(result)
  $(target).dropdown('clear')
  $(target).dropdown('set selected', '')

clear_options = (target, label) ->
  $(target).html(default_option(label))
  $(target).dropdown('clear')
  $(target).dropdown('set selected', '')

city_element      = get_element_id('city')
group_element     = get_element_id('district-group')
district_element  = get_element_id('district')
block_element     = get_element_id('block')

groups            = $(group_element).html()
districts         = $(district_element).html()
blocks            = $(block_element).html()

city_change_listener = (selected_value) ->
  set_options(selected_value, groups, group_element, 'Selecione')
  clear_options(district_element, 'Selecione')
  clear_options(block_element, 'Selecione')

group_change_listener = (selected_value) ->
  set_options(selected_value, districts, district_element, 'Selecione')
  clear_options(block_element, 'Selecione')

district_change_listener = (selected_value) ->
  if block_element
    set_options(selected_value, blocks, block_element, 'Selecione')

$(city_element).change ->
  selected_value = selected_item(city_element).text()
  city_change_listener(selected_value)

$(group_element).change ->
  selected_value = selected_item(group_element).text()
  group_change_listener(selected_value)

$(district_element).change ->
  selected_value = selected_item(district_element).text()
  district_change_listener(selected_value)
