class AdvertisementsController < ApplicationController
  layout 'base'

  def new
    @customer_common = CustomerCommon.new
    @customer_common.customers.build
  end

  def create
    @customer_common = CustomerCommon.new(allowed_params)
    @customer_common.fantasy_name = @customer_common.customers.first.name

    if @customer_common.save
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
        :owner_email
      ]
    )
  end
end
