require 'rails_helper'

RSpec.describe Twitter::UseCases::WeatherInformation do
  let(:weather_information) { described_class.new }

  describe '#execute' do
    let(:message) { '17°C e nuvens dispersas em Piraju em 27/01. Média para os próximos dias: 18°C em 28/01, 16°C em 29/01, 15°C em 30/01, 20°C em 31/01, 19°C em 01/02' }

    before do
      allow(weather_information).to receive(:execute).and_return(message)
    end

    it 'returns formatted weather information' do
      expect(weather_information.execute(123)).to eq(message)
    end
  end
end
