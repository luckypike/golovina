# frozen_string_literal: true

RSpec.describe Api::ColorsController, :aggregate_failures do
  subject(:ctrl) { post(:create, params: params) }

  let(:params) do
    {
      title_ru: Faker::Color.color_name,
      title_en: Faker::Color.color_name,
      color: Faker::Color.hex_color
    }
  end

  before do
    cookies[:_golovina_jwt] = generate_test_jwt(user.id)
    allow(Colors::CreateCmd).to receive(:call).and_call_original
    allow(Colors::CreateAndUpdateResource).to receive(:new).and_call_original
  end

  context "when user is an editor" do
    let(:user) { create(:api_user, editor: true) }

    it do
      expect(ctrl).to have_http_status(:ok)
      expect(Colors::CreateCmd).to have_received(:call)
      expect(Colors::CreateAndUpdateResource).to have_received(:new)
    end
  end

  context "when user is not editor" do
    let(:user) { create(:api_user) }

    it do
      expect(ctrl).to have_http_status(:unauthorized)
      expect(Colors::CreateCmd).not_to have_received(:call)
      expect(Colors::CreateAndUpdateResource).not_to have_received(:new)
    end
  end

  context "when user is anon" do
    let(:user) { build(:api_user) }

    it do
      expect(ctrl).to have_http_status(:unauthorized)
      expect(Colors::CreateCmd).not_to have_received(:call)
      expect(Colors::CreateAndUpdateResource).not_to have_received(:new)
    end
  end
end
