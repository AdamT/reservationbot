class Table < ActiveRecord::Base
  validates :seats, uniqueness: true

  has_many :reservations

  scope :most_seats,  -> { order('seats desc').first.seats }
  scope :can_be_used, ->(size) { where('seats >= ?', size) }
end
