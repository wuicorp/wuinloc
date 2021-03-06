require 'rails_helper'

describe Cell do
  describe '.at' do
    let(:cell) do
      described_class.create(longitude: 0.0, latitude: 0.0)
    end

    before { cell }

    subject { described_class.at(0.000001, 0.000001) }

    it { is_expected.to eq cell }
  end

  describe '.cells_for' do
    let(:radius) { 10 }

    subject do
      [].tap do |cells|
        described_class.cells_for(latitude, longitude, radius) { |id| cells << id }
      end.map { |cell| "#{cell.longitude}:#{cell.latitude}" }
    end

    context 'on the midle of earth surface' do
      let(:latitude) { 0.0 }
      let(:longitude) { 0.0 }

      it do
        is_expected
          .to eq ["-0.00009:-0.000085", "-0.00009:0.0", "-0.00009:0.000085", "0.0:-0.000085", "0.0:0.0", "0.0:0.000085", "0.00009:-0.000085", "0.00009:0.0", "0.00009:0.000085"]
      end
    end

    context 'on the northest of the earth surface' do
      let(:latitude) { 0.0 }
      let(:longitude) { 85.0 }

      it do
        is_expected
          .to eq ["-0.00009:84.999915", "-0.00009:85.0", "0.0:84.999915", "0.0:85.0", "0.00009:84.999915", "0.00009:85.0"]
      end
    end

    context 'on the southest of the earth surface' do
      let(:latitude) { 0.0 }
      let(:longitude) { -85.0 }

      it do
        is_expected
          .to eq ["-0.00009:-85.0", "-0.00009:-84.999915", "0.0:-85.0", "0.0:-84.999915", "0.00009:-85.0", "0.00009:-84.999915"]
      end
    end

    context 'on the eastest of the earth surface' do
      let(:latitude) { 180.0 }
      let(:longitude) { 0.0 }

      it do
        is_expected
          .to eq ["179.99991:-0.000085", "179.99991:0.0", "179.99991:0.000085", "180.0:-0.000085", "180.0:0.0", "180.0:0.000085", "-179.99991:-0.000085", "-179.99991:0.0", "-179.99991:0.000085"]
      end
    end

    context 'on the westest of the earth surface' do
      let(:latitude) { -180.0 }
      let(:longitude) { 0.0 }

      it do
        is_expected
          .to eq ["179.99991:-0.000085", "179.99991:0.0", "179.99991:0.000085", "-180.0:-0.000085", "-180.0:0.0", "-180.0:0.000085", "-179.99991:-0.000085", "-179.99991:0.0", "-179.99991:0.000085"]
      end
    end
  end

  describe '.steps_from_radius' do
    subject { described_class.steps_from_radius(100) }
    it { is_expected.to eq [10, 10] }
  end
end
