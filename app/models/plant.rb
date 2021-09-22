class Plant < ApplicationRecord
  has_many :plot_plants
  has_many :plots, through: :plot_plants

  def fetch_plot_plant(plot_id)
    PlotPlant.find_by(plot_id: plot_id, plant_id: id)
  end
end
