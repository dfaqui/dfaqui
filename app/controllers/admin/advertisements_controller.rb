class Admin::AdvertisementsController < Admin::BaseController
  before_action :set_advertisement, only: [:update, :destroy]

  def index
    @customers =  Customer.
                  where(status: Customer.status.pending_approval.value).
                  reorder(created_at: :desc)
  end

  def update
    @advertisement.update_attribute(:status, Customer.status.active)
    AdvertisementMailer.approved_advertisement(@advertisement).deliver
    flash[:notice] = 'Anúncio aprovado com sucesso'
  end

  def destroy
    @advertisement.destroy
    flash[:notice] = 'Anúncio rejeitado com sucesso'
  end

  private

  def set_advertisement
    @advertisement = Customer.find(params[:id])
  end
end
