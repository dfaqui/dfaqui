@get_element_id = (data_name) ->
  result = $("[data-#{data_name}]").data("#{data_name}")
  "##{result}"

@selected_item = (element) ->
  $("#{element} :selected")

@default_option = (label) ->
  "<option value=''>#{label}</option>"

@set_options = (optiongroup, options, target, label) ->
  result = default_option(label)
  result += $(options).filter("optgroup[label='#{optiongroup}']").html()

  $(target).html(result)

@clear_options = (target, label) ->
  $(target).html(default_option(label))
