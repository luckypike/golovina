# frozen_string_literal: true

RSpec.describe Api::VariantsController, :aggregate_failures do
  # describe "#new" do
  # end

  describe "#create" do
    subject(:cmd) { post :create, params: params }

    let(:params) { { format: :json } }

    before { allow(Variants::CreateCmd).to receive(:call).and_return(true) }

    context "when user can create" do
      let(:user) { create(:user, :editor) }

      before { sign_in(user) }

      it do
        expect(cmd).to have_http_status(:ok)
        expect(Variants::CreateCmd).to have_received(:call)
          .with(variant_params: instance_of(ActionController::Parameters))
      end
    end

    context "when user has not access" do
      it do
        expect(cmd).to have_http_status(:unauthorized)
        expect(Variants::CreateCmd).not_to have_received(:call)
      end
    end
  end

  describe "#update" do
    subject { patch :update, params: params }

    let(:color) { create(:color) }
    let(:variant) { create(:variant) }
    let(:params) { { id: variant.id, format: :json } }

    before { allow(Variants::UpdateCmd).to receive(:call).and_return(true) }

    context "when user can create" do
      let(:user) { create(:user, :editor) }

      before { sign_in(user) }

      it do
        expect(cmd).to have_http_status(:ok)
        expect(Variants::UpdateCmd).to have_received(:call)
          .with(variant: variant, variant_params: instance_of(ActionController::Parameters))
      end
    end

    context "when user has not access" do
      it do
        expect(cmd).to have_http_status(:unauthorized)
        expect(Variants::UpdateCmd).not_to have_received(:call)
      end
    end
  end
end
