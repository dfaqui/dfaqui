class MessageMailer < ApplicationMailer
  def lead_email(message)
    @message = message
    mail(to: @message.messageable.customer.contact_email, subject: 'DFaqui - Nova mensagem')
  end
end
