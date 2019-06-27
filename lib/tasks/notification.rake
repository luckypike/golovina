namespace :notification do
  desc "TODO"
  task send_notice: :environment do
    Variant.where(state: :active).each do |variant|
      variant.notifications.each do |notification|
        NotifyMailer.notify_mailer(notification).deliver_later
        notification.destroy
      end
    end
  end
end
