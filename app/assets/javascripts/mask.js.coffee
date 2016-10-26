jQuery ->
  # Mask definitions
  maskBehavior = (val) ->
    if val.replace(/\D/g, '').length == 11 then '(00) 00000-0000' else '(00) 0000-00009'

  options = onKeyPress: (val, e, field, options) ->
    field.mask maskBehavior.apply({}, arguments), options
    return

  $('.phone').mask(maskBehavior, options)
  $('.zipcode').mask('00000-000')
  $('.person_document').mask('000.000.000-00')
  $('.company_document').mask('00.000.000/0000-00')
  $('.only_number').mask('0#')
  $('.money').mask('#.##0,00', {reverse: true});
  # End of mask definitions

  # Handles document mask on customer type changes
  customer_type_element = 'customer_customer_type'
  document_element      = 'customer_document'

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
