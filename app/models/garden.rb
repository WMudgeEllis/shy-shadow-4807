class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots

  def distinct_plants
    plants.distinct
  end
end
