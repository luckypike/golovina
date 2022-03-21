# frozen_string_literal: true

# RSpec.describe Instagram::UpdateCmd, :aggregate_failures do
#   subject(:cmd) { described_class.call }

#   let(:access_token) { Random.hex }
#   let(:token) { create(:token, key: :instagram, value: access_token) }

#   describe "#call" do
#     before do
#       stub_request(
#         :get,
#         "https://graph.instagram.com/me/media?access_token=#{token.value}&fields=id,media_type,media_url,permalink"
#       ).to_return(response)
#     end

#     context "when IG returns 200" do
#       let(:response) do
#         {
#           status: 200,
#           body: { data: data }.to_json,
#           headers: { content_type: "application/json" }
#         }
#       end

#       let(:data) { [{ id: "12345" }] }

#       it do
#         cmd

#         expect(Rails.cache.read("instagram")).to match(data)
#       end
#     end

#     context "when IG returns errors" do
#       let(:response) do
#         {
#           status: 400,
#           body: "Sorry, this content isn't available right now"
#         }
#       end

#       it do
#         expect { cmd }.to raise_error(StandardError)
#       end
#     end

#     context "when token not found" do
#       let(:token) { create(:token, key: :ig, value: access_token) }
#       let(:response) { {} }

#       it do
#         expect { cmd }.to raise_error(ActiveRecord::RecordNotFound)
#       end
#     end
#   end
# end
