# frozen_string_literal: true

RSpec.describe Carts::CheckoutCmd, :aggregate_failures do
  subject(:cmd) { described_class.call(order: order, checkout_params: checkout_params) }

  let(:user) { create(:api_user) }

  describe "#call" do
    context "when order is correct and valid params" do
      let(:order) { create(:api_order, :cart, user: user) }
      let(:checkout_params) { {} }

      it do
        expect { cmd }.to raise_error(ServiceActor::Failure)
      end
    end

    context "when email and phone exists on one user" do
      let(:user_guest) { create(:api_user, :guest) }
      let(:order) { create(:api_order, :cart, user: user_guest) }
      let(:user) { create(:user, phone: "+79999999999") }
      let(:checkout_params) do
        {
          name: "Summer", sname: "Smith",
          email: user.email, phone: user.phone
        }
      end

      before do
        create(:api_order, :paid, user: user)
      end

      it do
        expect { cmd }.to raise_error(ServiceActor::Failure) do |e|
          expect(e.result.http_status_code).to eq(:forbidden)
        end
      end
    end

    context "when email and phone exists on two sep users" do
      let(:user_guest) { create(:api_user, :guest) }
      let(:order) { create(:api_order, :cart, user: user_guest) }
      let(:user) { create(:user, phone: "+79999999999") }
      let(:user_another) { create(:user, phone: "+78888888888") }
      let(:checkout_params) do
        {
          name: "Jerry", sname: "Smith",
          email: user.email, phone: user_another.phone
        }
      end

      before do
        create(:api_order, :paid, user: user)
      end

      it do
        expect { cmd }.to raise_error(ServiceActor::Failure) do |e|
          expect(e.result.http_status_code).to eq(:unprocessable_entity)
        end
      end
    end

    context "with apple ID user with phone" do
      let(:user_apple_id) { create(:api_user, :apple_id) }
      let(:order) { create(:api_order, :cart, user: user_apple_id) }
      let(:user) { create(:user, phone: "+79999999999") }
      let(:checkout_params) do
        {
          name: "Jerry", sname: "Smith",
          email: user.email, phone: user.phone
        }
      end

      before do
        create(:api_order, :paid, user: user)
      end

      it do
        expect { cmd }.to raise_error(ServiceActor::Failure) do |e|
          expect(e.result.http_status_code).to eq(:forbidden)
        end
      end
    end

    context "with apple ID user without phone" do
      let(:user_apple_id) { create(:api_user, :apple_id) }
      let(:order) { create(:api_order, :cart, user: user_apple_id) }
      let(:user) { create(:user, phone: "+79999999999") }
      let(:checkout_params) do
        {
          name: "Jerry", sname: "Smith",
          email: user.email, phone: "+78888888888"
        }
      end

      before do
        create(:api_order, :paid, user: user)
      end

      it do
        expect { cmd }.to raise_error(ServiceActor::Failure) do |e|
          expect(e.result.http_status_code).to eq(:unprocessable_entity)
        end
      end
    end

    context "with regular user with phone" do
      let(:user_active) { create(:api_user) }
      let(:order) { create(:api_order, :cart, user: user_active) }
      let(:user) { create(:user, phone: "+79999999999") }
      let(:checkout_params) do
        {
          name: "Beth", sname: "Smith",
          email: user.email, phone: user.phone
        }
      end

      before do
        create(:api_order, :paid, user: user)
      end

      it do
        expect { cmd }.to raise_error(ServiceActor::Failure) do |e|
          expect(e.result.http_status_code).to eq(:forbidden)
        end
      end
    end

    context "with regular user without phone" do
      let(:user_active) { create(:api_user) }
      let(:order) { create(:api_order, :cart, user: user_active) }
      let(:user) { create(:user, phone: "+79999999999") }
      let(:checkout_params) do
        {
          name: "Beth", sname: "Smith",
          email: user.email, phone: "+78888888888"
        }
      end

      before do
        create(:api_order, :paid, user: user)
      end

      it do
        expect { cmd }.to raise_error(ServiceActor::Failure) do |e|
          expect(e.result.http_status_code).to eq(:unprocessable_entity)
        end
      end
    end

    context "with regular user with another email and same phone" do
      let(:user_active) { create(:api_user) }
      let(:order) { create(:api_order, :cart, user: user_active) }
      let(:user) { create(:user, phone: "+79999999999") }
      let(:checkout_params) do
        {
          name: "Beth", sname: "Smith",
          email: "another@example.com", phone: user.phone
        }
      end

      before do
        create(:api_order, :paid, user: user)
      end

      it do
        expect { cmd }.to raise_error(ServiceActor::Failure) do |e|
          expect(e.result.http_status_code).to eq(:forbidden)
        end
      end
    end
  end
end
