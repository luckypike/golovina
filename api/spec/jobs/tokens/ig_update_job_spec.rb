# frozen_string_literal: true

RSpec.describe Tokens::IgUpdateJob, :aggregate_failures do
  describe "#perform" do
    subject(:cmd) { described_class.perform_now }

    before do
      allow(Tokens::IgUpdateCmd).to receive(:call).and_return(true)

      create(:token, key: :instagram)
      create(:token, key: :instagram, expires_at: 1.day.from_now)
      create(:token, key: :instagram, expires_at: 1.day.ago)
    end

    it do
      cmd

      expect(Tokens::IgUpdateCmd).to have_received(:call).with(token: a_kind_of(Token))
    end
  end
end
