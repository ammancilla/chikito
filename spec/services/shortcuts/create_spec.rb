RSpec.describe Shortcuts::Create do
  subject(:service) { -> { described_class.call(url: url) } }

  let(:url) { Faker::Internet.url }

  it 'creates a Shortcut' do
    expect { service.call }.to change { Shortcut.count }.from(0).to(1)
  end

  context 'when invalid url' do
    let(:url) { 'invalid_url' }

    it 'does not create a Shortcut' do
      expect { service.call }.to not_change { Shortcut.count }
    end
  end
end
