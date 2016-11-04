class AdvertisementMailer < ApplicationMailer
  def new_customer(customer, generated_password)
    @customer           = customer
    @generated_password = generated_password

    image = Rails.root.join('app', 'assets', 'images', 'dfaqui_brand.png')
    attachments.inline['dfaqui_brand.png'] = File.read(image)

    mail(to: @customer.owner_email, subject: 'DFaqui - Bem-vindo')
  end
end
