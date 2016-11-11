class AdvertisementMailer < ApplicationMailer
  def new_advertisement(customer, generated_password, is_new_user)
    subjects  = ['Novo anúncio', 'Bem-vindo']
    templates = ['new_advertisement', 'new_advertisement_user']

    @customer           = customer
    @generated_password = generated_password

    image = Rails.root.join('app', 'assets', 'images', 'dfaqui_brand.png')
    attachments.inline['dfaqui_brand.png'] = File.read(image)

    mail(
      to: @customer.owner_email,
      subject: "DFaqui - #{subjects[is_new_user]}",
      template_name: templates[is_new_user]
    )
  end
end
