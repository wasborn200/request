class MessagesController < ApplicationController
  def index
    @messages = Message.where(to_id: current_user.id).last(500)
  end
end
