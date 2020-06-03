class OrderMailerPreview < ActionMailer::Preview
  def tracker
    OrderMailer.with(order: Order.last).tracker
  end

  def payed
    OrderMailer.with(order: Order.last).payed
  end
end
