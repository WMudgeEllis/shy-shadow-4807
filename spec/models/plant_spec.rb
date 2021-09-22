require "rails_helper"

RSpec.describe Plant do

  describe 'relationships' do
    it { should have_many(:plot_plants) }
    it { should have_many(:plots).through(:plot_plants) }
  end

  it 'can fetch the plot_plant' do
    garden = Garden.create!(name: 'awesome space', organic: true)
    plot_1 = garden.plots.create!(number: 35, size: 'Bigly', direction: 'up')
    plot_2 = garden.plots.create!(number: 20, size: 'Smally', direction: 'down')

    plant_1 = Plant.create!(name: 'shrubbery', description: 'is in awfully high demand', days_to_harvest: 200)

    plot_2.plants << plant_1

    plot_plant = PlotPlant.create!(plot: plot_1, plant: plant_1)

    expect(plant_1.fetch_plot_plant).to eq(plot_plant)
  end
end
