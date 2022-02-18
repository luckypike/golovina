# frozen_string_literal: true

RSpec.describe Carts::ShowCmd, :aggregate_failures do
  subject { described_class.call(user: user) }
  let(:user) { create(:api_user) }

  describe '#call' do
    it do
      subject
    end
  end
end
