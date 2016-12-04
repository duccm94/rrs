module ActivityLog
  extend ActiveSupport::Concern

  def create_activity onwer_id, target_id, target_type, action
    Activity.create(user_id: onwer_id, target_id: target_id,
      target_type: target_type, action_type: action)
  end

  def create_notification owner_id, recipient_id, content, review_id
    if owner_id =! recipient_id
      Notification.create! owner_id: owner_id, recipient_id: recipient_id,
        content: content, review_id: review_id
    end
  end
end
