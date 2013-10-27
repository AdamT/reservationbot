require 'spec_helper'

describe 'add reservation', type: :feature do

  it 'for 0', js: true do
    pending ''
  end

  it 'for 2', js: true do
    go_to_reservations
    book_for 5
    on_day(3)
    save_and_open_page
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
  visit root_path
  click_link 'Book a table'
end

def book_for(group_size)
  page.select(group_size, from: 'reservation_group_size')
end

def on_day(day)
  #page.find('#reservation_time').trigger(:click)
  #page.find('#reservation_time').trigger(:mouseover)
  find('#reservation_time').click
  within('.ui-datepicker-calendar') do
    click_on 10
  end
  #page.execute_script %Q{ $('#reservation_time').trigger("focus") } # activate datetime picker
  #page.execute_script %Q{ $('a.ui-datepicker-next').trigger("click") } # move one month forward
  #page.execute_script %Q{ $("a.ui-state-default:contains('15')").trigger("click") } # click on day 15
  sleep 5
end

