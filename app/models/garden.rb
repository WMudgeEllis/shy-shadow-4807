class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots

  def distinct_plants
    plants.distinct
  end

  def plants_with_short_harvest_times
    distinct_plants.where('plants.days_to_harvest < ?', '100')
  end
end
