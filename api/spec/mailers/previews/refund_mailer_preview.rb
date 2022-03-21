# frozen_string_literal: true

class RefundMailerPreview < ActionMailer::Preview
  def create
    RefundMailer.with(refund: Refund.last).create
  end
end
