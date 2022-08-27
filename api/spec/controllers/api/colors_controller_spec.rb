# frozen_string_literal: true

RSpec.describe Api::ColorsController, :aggregate_failures do
  describe "#index" do
    subject(:ctrl) { get :index }

    before do
      cookies[:_golovina_jwt] = generate_test_jwt(user.id)
      allow(Colors::IndexCmd).to receive(:call).and_call_original
      allow(Colors::IndexResource).to receive(:new).and_call_original
      create_list(:api_color, 5, :with_colors)
    end

    context "when user is an editor" do
      let(:user) { create(:api_user, editor: true) }

      it do
        expect(ctrl).to have_http_status(:ok)
        expect(Colors::IndexCmd).to have_received(:call)
        expect(Colors::IndexResource).to have_received(:new)
      end
    end

    context "when user is not editor" do
      let(:user) { create(:api_user) }

      it do
        expect(ctrl).to have_http_status(:unauthorized)
        expect(Colors::IndexCmd).not_to have_received(:call)
        expect(Colors::IndexResource).not_to have_received(:new)
      end
    end

    context "when user is anon" do
      let(:user) { build(:api_user) }

      it do
        expect(ctrl).to have_http_status(:unauthorized)
        expect(Colors::IndexCmd).not_to have_received(:call)
        expect(Colors::IndexResource).not_to have_received(:new)
      end
    end
  end

  describe "#show" do
    subject(:ctrl) { get(:show, params: { id: color.id }) }

    let(:color) { create(:api_color) }

    before do
      cookies[:_golovina_jwt] = generate_test_jwt(user.id)
      allow(Colors::ShowCmd).to receive(:call).and_call_original
      allow(Colors::ShowResource).to receive(:new).and_call_original
    end

    context "when user is an editor" do
      let(:user) { create(:api_user, editor: true) }

      it do
        expect(ctrl).to have_http_status(:ok)
        expect(Colors::ShowCmd).to have_received(:call)
        expect(Colors::ShowResource).to have_received(:new)
      end

      context "when no color" do
        let(:color) { build(:api_color, id: 0) }

        it do
          expect(ctrl).to have_http_status(:not_found)
          expect(Colors::ShowCmd).to have_received(:call)
          expect(Colors::ShowResource).not_to have_received(:new)
        end
      end
    end

    context "when user is not editor" do
      let(:user) { create(:api_user) }

      it do
        expect(ctrl).to have_http_status(:unauthorized)
        expect(Colors::ShowCmd).not_to have_received(:call)
        expect(Colors::ShowResource).not_to have_received(:new)
      end
    end

    context "when user is anon" do
      let(:user) { build(:api_user) }

      it do
        expect(ctrl).to have_http_status(:unauthorized)
        expect(Colors::ShowCmd).not_to have_received(:call)
        expect(Colors::ShowResource).not_to have_received(:new)
      end
    end
  end
end
