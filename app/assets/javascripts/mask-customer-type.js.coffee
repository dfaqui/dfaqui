#= require filter

jQuery ->
  # Handles document mask on customer type changes
  customer_type_element = get_element_id('type').replace('#', '')
  document_element      = get_element_id('document').replace('#', '')

  handle_customer_type = ->
    selected_value = $("##{customer_type_element}").val()

    if selected_value == 'person'
      label = 'CPF'
      mask  = 'person_document'
    else if selected_value == 'company'
      label = 'CNPJ'
      mask  = 'company_document'

    $("label[for='#{document_element}']").text(label)
    $("##{document_element}").removeClass('person_document company_document').addClass(mask)

  $("##{customer_type_element}").change ->
    handle_customer_type()
