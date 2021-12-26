require 'rails_helper'

describe OrdersController do
  describe 'PATCH #checkout' do
    context 'from guest user order' do
      let(:guest_user) { create(:guest_user) }
      let(:order) { create(:order, user: guest_user) }

      context 'by anonymous user' do
        before do
          patch :checkout, params: {
            id: order.id,
            order: {},
            format: :json
          }
        end

        it { should redirect_to(new_user_session_path) }
      end

      context 'by owner user' do
        before do
          sign_in guest_user
        end

        context 'without params' do
          before do
            patch :checkout, params: {
              id: order.id,
              order: {
                delivery: ''
              },
              format: :json
            }
          end

          it { should respond_with(:unprocessable_entity) }
        end

        context 'with params' do
          before do
            patch :checkout, params: {
              id: order.id,
              order: {
                delivery: :pickup,
                user_attributes: {
                  name: Faker::Name.first_name,
                  sname: Faker::Name.last_name,
                  phone: Faker::PhoneNumber.cell_phone_with_country_code
                }
              },
              format: :json
            }
          end

          it { should respond_with(:ok) }
        end
      end
    end

    # context 'by guest user' do
    #   let(:guest_user) { create(:guest_user) }
    #   let(:order) { create(:order, user: guest_user) }
    #
    #
    #
    #   it 'does not checkout order' do
    #     patch :checkout, params: {
    #       id: order.id,
    #       order: {},
    #       format: :json
    #     }
    #
    #     expect(response).to redirect_to(new_user_session_path)
    #     # expect(response).to have_http_status(:unprocessable_entity)
    #   end
    # end
  end
end
