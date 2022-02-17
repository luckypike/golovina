# frozen_string_literal: true

describe PagesController do
  describe 'GET #robots' do
    context 'as HTML' do
      it 'renders the robots template' do
        expect { get :robots }.to raise_error(ActionController::UnknownFormat)
      end
    end

    context 'as TEXT' do
      it 'renders the robots template' do
        get :robots, format: :text

        expect(response).to render_template('robots')
      end
    end
  end
end
