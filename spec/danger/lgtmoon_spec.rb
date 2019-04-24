RSpec.describe Danger::Lgtmoon do
  it "has a version number" do
    expect(Danger::Lgtmoon::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end

  describe '#greet' do
    it 'returns "Hello World!"' do
      expect(Danger::Lgtmoon.greet).to eq('Hello World!')
    end
  end
end
