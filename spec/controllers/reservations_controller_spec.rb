require 'spec_helper'

describe ReservationsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      expect(response).to be_success
    end
  end

  describe "POST 'create'" do
    before(:each) do
      @table_for_2 = FactoryGirl.create(:table, seats: 2)
      @table_for_4 = FactoryGirl.create(:table, seats: 4)
      @params = {
        reservation: {group_size: 2, time: '2013-10-01'},
        hours: 5,
        minutes: 0
      }
    end

    it 'no prior reservations' do

      post :create, @params
      expect(response).to be_redirect
    end

    it 'success, same time, larger group' do
      @table_for_4.reservations << reservation_for_4

      post :create, @params
      expect(response).to be_redirect
    end

    it 'success, same time, smaller group' do
      @table_for_2.reservations << reservation_for_2

      post :create, @params
      expect(response).to be_redirect
    end

    it 'success, different day, same group' do
      @table_for_2.reservations << reservation_for_2
      @params[:reservation][:time] = '2013-11-01'

      post :create, @params
      expect(response).to be_redirect
    end

    it 'success, 2 hours later, same group' do
      @table_for_2.reservations << reservation_for_2
      @params[:hours] = 7

      post :create, @params
      expect(response).to be_redirect
    end

    it 'success, 2 hours later, tables full at 5' do
      @table_for_2.reservations << reservation_for_2
      @table_for_4.reservations << reservation_for_4
      @params[:hours] = 7

      post :create, @params
      expect(response).to be_redirect
    end

    it 'success, 2 hours later, tables full at 5, party of 4' do
      @table_for_2.reservations << reservation_for_2
      @table_for_4.reservations << reservation_for_4
      @params[:hours] = 7
      @params[:reservation][:group_size] = 4

      post :create, @params
      expect(response).to be_redirect
    end

    it 'fail, same time, tables full' do
      @table_for_4.reservations << reservation_for_4
      @table_for_2.reservations << reservation_for_2

      post :create, @params
      expect(response).to_not be_redirect
    end

    it 'fail, within 1 hour, tables full' do
      @table_for_4.reservations << reservation_for_4
      @table_for_2.reservations << reservation_for_2

      post :create, @params
      expect(response).to_not be_redirect
    end

    it 'fail, too many people' do
      @params[:reservation][:group_size] = 8

      post :create, @params
      expect(response).to_not be_redirect
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
  end

end

def reservation_for_2
  FactoryGirl.create(
    :reservation,
    time: '2013-10-01 05:00:00',
    group_size: 2
  )
end

def reservation_for_4
  FactoryGirl.create(
    :reservation,
    time: '2013-10-01 05:00:00',
    group_size: 4
  )
end
