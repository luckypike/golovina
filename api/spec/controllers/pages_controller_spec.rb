require 'rails_helper'

describe PagesController do
  describe 'GET #index' do
    it 'renders the index template' do
      get :index

      expect(response).to render_template('index')
    end
  end

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

  describe 'GET #contacts' do
    it 'renders the contacts template' do
      get :contacts

      expect(response).to render_template('contacts')
    end
  end
end
