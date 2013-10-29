require 'spec_helper'

describe Reservation do
  before(:each) do
    @table_for_2 = FactoryGirl.create(:table, seats: 2)
    @table_for_4 = FactoryGirl.create(:table, seats: 4)
    @params = {
      reservation: {group_size: 2, time: '2013-10-01'},
      hours: 5,
      minutes: 0
    }
  end

  it { should belong_to(:table) }

  it 'reservation is not nil' do
    expect(Reservation.setup(@params).id).to_not be_nil
  end

  it 'is valid' do
    reservation = Reservation.setup(@params)

    expect(reservation.is_valid?).to be true
  end

  describe '.setup' do
    it 'returns a reservation' do
      expect(Reservation.setup(@params)).to be_a(Reservation)
    end
  end

  describe '#is_valid?' do
    it 'returns true' do
      reservation = Reservation.setup(@params)
      expect(reservation.is_valid?).to be true
    end
  end
end
