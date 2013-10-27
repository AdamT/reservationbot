require 'spec_helper'

describe Table do
  before(:each) do
    @table_for_2 = FactoryGirl.create(:table, seats: 2)
    @table_for_4 = FactoryGirl.create(:table, seats: 4)
  end

  it { should have_many(:reservations) }
  it { should validate_uniqueness_of(:seats) }

  it 'has most_seats scope' do
    expect(Table.most_seats).to eql(@table_for_4.seats)
  end

  it 'has 2 tables with 2 or more seats' do
    expect(Table.can_be_used(2).count).to eql(2)
  end

  it 'has 1 table with 3 or more seats' do
    expect(Table.can_be_used(3).count).to eql(1)
  end
end
