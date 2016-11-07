class AdvertisementsController < ApplicationController
  def new
    @customer = Customer.new
  end

  def create
    @customer           = Customer.new(allowed_params)
    generated_password  = Devise.friendly_token.first(10)

    if @customer.create_advertisement_customer(generated_password)
      AdvertisementMailer.new_customer(@customer, generated_password).deliver
      partial = 'create'
    else
      @customer.errors.delete(:fantasy_name)
      partial = 'error'
    end

    render "advertisements/#{partial}"
  end

  private

  def allowed_params
    params.require(:customer).permit(
      :plugin,
      :customer_type,
      :document,
      :name,
      :owner_name,
      :owner_phone,
      :owner_email
    )
  end
end
