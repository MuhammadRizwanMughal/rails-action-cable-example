class MessagesController < ApplicationController
  def new
    @message = Message.new
  end
  def create
    @message = Message.new(msg_params)
    if @message.save
      ActionCable.server.broadcast "room_channel",
                                   content: @message.content
    else
      flash[:danger] = "Unable to send message";
      redirect_to root_url
    end
  end
  private
  def msg_params
    params.require(:message).permit(:content)
  end
end
