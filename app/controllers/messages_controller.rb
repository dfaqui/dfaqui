class MessagesController < ApplicationController
  def index
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(allowed_params)

    if @message.save
      MessageMailer.lead_email(@message).deliver
      partial = 'create'
    else
      partial = 'error'
    end

    render "messages/#{partial}"
  end

  private

  def allowed_params
    params.required(:message).permit(
      :name,
      :email,
      :phone,
      :content,
      :messageable_id,
      :messageable_type
    )
  end
end
