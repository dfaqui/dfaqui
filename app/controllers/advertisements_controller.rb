class AdvertisementsController < ApplicationController
  layout 'base'

  def new
    @customer_common = CustomerCommon.new
    @customer_common.customers.build
  end

  def create
    @customer_common      = CustomerCommon.new(allowed_params)
    generated_password    = Devise.friendly_token.first(10)

    if @customer_common.create_advertisement_customer(generated_password)
      AdvertisementMailer.new_customer(@customer_common.customers.first, generated_password).deliver
      partial = 'create'
    else
      @customer_common.errors.delete(:fantasy_name)
      partial = 'error'
    end

    render "advertisements/#{partial}"
  end

  private

  def allowed_params
    params.require(:customer_common).permit(
      :plugin,
      customers_attributes: [
        :id,
        :name,
        :customer_type,
        :document,
        :owner_name,
        :owner_phone,
        :owner_email,
        :status
      ]
    )
  end
end
