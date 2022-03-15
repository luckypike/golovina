# frozen_string_literal: true

RSpec.describe Carts::ShowCmd, :aggregate_failures do
  subject(:cmd) { described_class.call(user: user) }

  let(:user) { create(:api_user) }

  describe "#call" do
    # TODO: Add some test
    xit do
      cmd
    end
  end
end
