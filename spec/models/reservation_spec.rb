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

  describe '#is_valid?' do
    it 'returns true' do
      reservation = Reservation.new
      expect(reservation.is_valid?).to be true
    end

    it 'returns false' do
      reservation = Reservation.new
      reservation.errors[:base] << 'No tables available'
      expect(reservation.is_valid?).to be false
    end
  end
end
