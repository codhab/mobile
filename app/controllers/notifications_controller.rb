class NotificationsController < ApplicationController

  def index
    @count_notifications =  ::CandidateCadastre.find_by(cpf: params[:cpf]).attendance_notifications.unread.count rescue 0

    render json: @count_notifications
  end

end