require 'spec_helper'

describe 'add reservation', type: :feature do
  before(:each) do
    table1 = FactoryGirl.create(:table, seats: 2)
    table2 = FactoryGirl.create(:table, seats: 4)
  end

  it 'for 0', js: true do
    pending ''
  end

  it 'for 2', js: true do
    go_to_reservations
    book_for 5
    on_day(3)
    select_hour(6)
    select_minute(45)
    page.click_on("Book reservation")
    #page.click_button('Book reservation')

    sleep 5
    save_and_open_page
    #expect(page).to have_content 'Success'
  end

  it 'for 3', js: true do
    pending ''
  end

  it 'with time overlap, fail', js: true do
    pending ''
  end

  it 'with for 10, fail' do
    pending ''
  end

end

def go_to_reservations
  page.visit root_path
  page.click_link 'Book a table'
end

def book_for(group_size)
  page.select(group_size, from: 'reservation_group_size')
end

def on_day(day)
  find('#reservation_time').click
  within('.ui-datepicker-calendar') do
    click_on 10
  end
end

def select_hour(hour)
  puts hour.inspect
  page.select(hour.to_s + "PM", from: 'hours')
end

def select_minute(min)
  page.select(min, from: 'minutes')
end
