require 'rails_helper'

RSpec.describe "Shortcuts", type: :request do
  describe 'GET /' do
    it 'returns HTTP 200 and renders shortcuts/new' do
      get root_path

      expect(response).to render_template(:new)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /shortcuts' do
    subject(:send_request) { post shortcuts_path, params: { shortcut: { url: url } } }

    context 'when given a valid URL' do
      let(:url) { Faker::Internet.url }
      # let(:shortcut) { build :shortcut }

      # before { allow(shortcut).to receive(:persisted?).and_return(true) }

      it 'creates a shortcut and renders shortcuts/create' do
        # expect(Shortcuts::Create).to receive(:call).with(url: url).and_return(shortcut)

        send_request

        expect(response).to render_template(:create)
        expect(response).to have_http_status(201)
        expect(response.body).to include(shortcut_url(assigns(:shortcut).key))
      end
    end

    context 'when given an invalid URL' do
      let(:url) { 'invalid_url' }

      it 'renders shortcuts/new and display proper error message(s)' do
        send_request

        expect(response).to render_template(:new)
        expect(response).to have_http_status(422)
        expect(response.body).to include("Url is invalid")
      end
    end
  end

  describe 'GET /:shortcut_key' do
    subject(:send_request) { get shortcut_path(shortcut_key) }

    let(:shortcut) { create :shortcut }
    let(:shortcut_key) { shortcut.key }

    it 'redirects to the original URL and sets proper cache headers' do
      send_request

      expect(response).to have_http_status(301)
      expect(response.headers['Location']).to eq(shortcut.url)
      expect(response.headers['Cache-Control']).to eq('max-age=31536000, private')
    end

    context 'when invalid :shortcut_key' do
      let(:shortcut_key) { 'invalid_shortcut_key' }

      it 'raises ActionController::UrlGenerationError' do
        expect { send_request }.to raise_error(ActionController::UrlGenerationError)
      end
    end

    context 'when non existant shortcut' do
      let(:shortcut_key) { 'a1b2c3d' }

      it 'raises ActiveRecord::RecordNotFound' do
        expect { send_request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
