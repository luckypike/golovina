# frozen_string_literal: true

class OrderMailerPreview < ActionMailer::Preview
  def tracker
    OrderMailer.with(order: Order.where.not(tracker_type: nil).last).tracker
  end

  def payed_pickup
    OrderMailer.with(order: Order.pickup.archived.last).payed
  end

  def payed_delivery
    OrderMailer.with(order: Order.russia.archived.last).payed
  end
end
