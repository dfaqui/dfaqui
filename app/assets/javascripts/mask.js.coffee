jQuery ->
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
