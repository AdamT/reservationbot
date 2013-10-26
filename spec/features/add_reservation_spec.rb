require 'spec_helper'

describe 'add reservation', type: :feature do

  it 'for 0', js: true do
    pending ''
  end

  it 'for 2', js: true do
    go_to_reservations
    book_for 2
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
  select group_size, from: 'group size'
end
