class WorkingHour < ApplicationRecord
  belongs_to :market

  validates :days, presence: true
  validates :opening_time, presence: true
  validates :closing_time, presence: true

  def days_as_string
    self.days.map{ |day| I18n.t('date.day_names')[day.to_i] }.join(', ')
  end

  def opening_time_hour
    self.opening_time.strftime('%H')
  end

  def closing_time_hour
    self.closing_time.strftime('%H')
  end

  def opening_time_hour_minute
    self.opening_time.strftime('%H:%M')
  end

  def closing_time_hour_minute
    self.closing_time.strftime('%H:%M')
  end
end
