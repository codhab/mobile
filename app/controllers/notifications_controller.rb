class NotificationsController < ApplicationController

  def index
    @count_notifications =  ::CoreAttendance::Candidate::Cadastre.find_by(cpf: params[:cpf]).notifications.unread.count rescue 0

    render json: @count_notifications
  end

end