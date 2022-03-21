# frozen_string_literal: true

RSpec.describe Api::ImagesController, :aggregate_failures do
  describe "#touch" do
    subject(:cmd) { post :touch, params: params }

    before { allow(Images::TouchCmd).to receive(:call).and_call_original }

    context "when user can create" do
      let(:params) { { filename: "img.jpg", content_type: "image/jpeg", byte_size: 1, checksum: "qwe", format: :json } }
      let(:user) { create(:user, :editor) }

      before { sign_in(user) }

      it do
        expect(cmd).to have_http_status(:ok)
        expect(Images::TouchCmd).to have_received(:call)
          .with(image_params: instance_of(ActionController::Parameters))
      end
    end
  end
end
