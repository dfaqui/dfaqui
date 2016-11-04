class AdvertisementMailer < ApplicationMailer
  def new_customer(customer, generated_password)
    @customer           = customer
    @generated_password = generated_password

    mail(to: @customer.owner_email, subject: 'DFaqui - Bem-vindo')
  end
end
