class OrderMailerPreview < ActionMailer::Preview
  def tracker
    OrderMailer.with(order: Order.where.not(tracker_type: nil).last).tracker
  end

  def payed
    OrderMailer.with(order: Order.last).payed
  end
end
