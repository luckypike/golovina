# frozen_string_literal: true

RSpec.describe Sessions::SignInWithAppleIdCmd, :aggregate_failures do
  subject(:cmd) do
    described_class.call(
      current_user: current_user, token_params: token_params,
      referer: referer, user_params: user_params
    )
  end

  describe "#call" do
    let(:current_user) { nil }
    let(:referer) { "https://appleid.apple.com/" }
    let(:email) { "email@example.com" }
    let(:token_params) { { sub: SecureRandom.uuid, iss: "https://appleid.apple.com", email: email }.stringify_keys }
    let(:user_params) { nil }

    context "when first time, user not exists and without relay" do
      let(:user_params) { { name: { firstName: "Adam", lastName: "Smith" } } }

      it do
        expect(cmd).to be_success
        expect(Api::Identity.find_by(provider: :apple, uid: token_params["sub"]).user_id)
          .to eq(Api::User.find_by(email: email).id)
      end

      it do
        expect(cmd).to be_success
        expect(Api::User.find_by(email: email).slice(:name, :sname, :email, :state))
          .to match({ name: "Adam", sname: "Smith", email: email, state: "active" })
      end

      it do
        expect { cmd }
          .to change(Api::User, :count).by(1)
          .and change(Api::Identity, :count).by(1)
      end
    end

    context "when first time, user not exists and with relay" do
      let(:email) { "abc123@privaterelay.appleid.com" }
      let(:user_params) { { name: { firstName: "Adam", lastName: "Smith" } } }

      it do
        expect(cmd).to be_success
        expect(Api::Identity.find_by(provider: :apple, uid: token_params["sub"]).user_id)
          .to eq(Api::User.find_by(email: email).id)
      end

      it do
        expect(cmd).to be_success
        expect(Api::User.find_by(email: email).slice(:name, :sname, :email, :state))
          .to match({ name: "Adam", sname: "Smith", email: email, state: "active" })
      end

      it do
        expect { cmd }
          .to change(Api::User, :count).by(1)
          .and change(Api::Identity, :count).by(1)
      end
    end

    context "when first time, user exists and without relay" do
      let(:user_params) { { name: { firstName: "Adam", lastName: "Smith" } } }

      before do
        create(:api_user, email: email, name: "Rick", sname: "Sanchez")
      end

      it do
        expect(cmd).to be_success
        expect(Api::Identity.find_by(provider: :apple, uid: token_params["sub"]).user_id)
          .to eq(Api::User.find_by(email: email).id)
      end

      it do
        expect(cmd).to be_success
        expect(Api::User.find_by(email: email).slice(:name, :sname, :email, :state))
          .to match({ name: "Rick", sname: "Sanchez", email: email, state: "active" })
      end

      it do
        expect { cmd }
          .to not_change(Api::User, :count)
          .and change(Api::Identity, :count).by(1)
      end
    end

    context "when first time, user exists and with relay" do
      let(:user_params) { { name: { firstName: "Adam", lastName: "Smith" } } }
      let(:email) { "abc123@privaterelay.appleid.com" }

      before do
        create(:api_user, email: email, name: "Rick", sname: "Sanchez")
      end

      it do
        expect(cmd).to be_success
        expect(Api::Identity.find_by(provider: :apple, uid: token_params["sub"]).user_id)
          .to eq(Api::User.find_by(email: email).id)
      end

      it do
        expect(cmd).to be_success
        expect(Api::User.find_by(email: email).slice(:name, :sname, :email, :state))
          .to match({ name: "Rick", sname: "Sanchez", email: email, state: "active" })
      end

      it do
        expect { cmd }
          .to not_change(Api::User, :count)
          .and change(Api::Identity, :count).by(1)
      end
    end

    context "when identity exists and without relay" do
      let(:email) { "abc123@privaterelay.appleid.com" }

      before do
        create(:api_user, phone: nil)
        user = create(:api_user, email: "email@example.com", name: "Rick", sname: "Sanchez")
        create(:identity, user: user, uid: token_params["sub"])
      end

      it do
        expect(cmd).to be_success
        expect(Api::User.find_by(email: "email@example.com").slice(:name, :sname, :email, :state))
          .to match({ name: "Rick", sname: "Sanchez", email: "email@example.com", state: "active" })
      end

      it do
        expect { cmd }
          .to not_change(Api::User, :count)
          .and not_change(Api::Identity, :count)
      end
    end

    context "when user was inactive" do
      let(:email) { "email@example.com" }

      before do
        user = create(:api_user, email: email, state: :guest)
        create(:identity, user: user, uid: token_params["sub"])
      end

      it do
        expect(cmd).to be_success
        expect(Api::User.find_by(email: "email@example.com").slice(:email, :state))
          .to match({ email: "email@example.com", state: "active" })
      end
    end

    context "when referer not from apple" do
      let(:referer) { "https://example.com" }

      it { expect { cmd }.to raise_error(ServiceActor::Failure) }
    end

    context "when inputs are empty" do
      let(:token_params) { nil }
      let(:referer) { nil }

      it do
        expect { cmd }.to raise_error(ServiceActor::Failure)
      end
    end
  end
end
