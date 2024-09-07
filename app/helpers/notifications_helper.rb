module NotificationsHelper
  def notification_message(notification)
    case notification.notifiable_type
    when "Book"
      "Following#{notification.notifiable.user.name}#{notification.notifiable.title} created a new post"
    else
      "#{notification.notifiable.title} post was liked by#{notification.notifiable.user.name}"
    end
  end
end
