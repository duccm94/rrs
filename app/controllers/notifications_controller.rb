class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.order_by_time.paginate page: params[:page], per_page: 5
  end

  def update
    @notification = Notification.find_by_id params[:id]
    if @notification
      @notification.update_attribute "seen", true
      redirect_to restaurant_review_path(@notification.target.book, @notification.target)
    end
  end
end
