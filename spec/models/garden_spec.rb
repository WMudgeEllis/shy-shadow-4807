require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots) }
  end

  it 'can get distinct plants' do
    garden = Garden.create!(name: 'awesome space', organic: true)
    garden_2 = Garden.create!(name: 'awful space', organic: false)
    plot_1 = garden.plots.create!(number: 35, size: 'Bigly', direction: 'up')
    plot_2 = garden.plots.create!(number: 20, size: 'Smally', direction: 'down')
    plot_3 = garden_2.plots.create!(number: 1, size: 'miniture', direction: 'diagonal')

    plant_1 = Plant.create!(name: 'shrubbery', description: 'is in awfully high demand', days_to_harvest: 20)
    plant_2 = Plant.create!(name: 'bush', description: 'is not in high demand', days_to_harvest: 50)
    plant_3 = Plant.create!(name: 'apple tree', description: 'is a tree', days_to_harvest: 17)
    plant_4 = Plant.create!(name: 'banana tree', description: 'is a tree', days_to_harvest: 17)

    plot_1.plants << plant_1
    plot_1.plants << plant_3

    plot_2.plants << plant_2
    plot_2.plants << plant_3

    plot_3.plants << plant_4

    expect(garden.distinct_plants).to eq([plant_1, plant_2, plant_3])
  end

  it 'can get distinct plants that have short harvest time' do
    garden = Garden.create!(name: 'awesome space', organic: true)
    garden_2 = Garden.create!(name: 'awful space', organic: false)
    plot_1 = garden.plots.create!(number: 35, size: 'Bigly', direction: 'up')
    plot_2 = garden.plots.create!(number: 20, size: 'Smally', direction: 'down')
    plot_3 = garden_2.plots.create!(number: 1, size: 'miniture', direction: 'diagonal')

    plant_1 = Plant.create!(name: 'shrubbery', description: 'is in awfully high demand', days_to_harvest: 20)
    plant_2 = Plant.create!(name: 'bush', description: 'is not in high demand', days_to_harvest: 101)
    plant_3 = Plant.create!(name: 'apple tree', description: 'is a tree', days_to_harvest: 17)
    plant_4 = Plant.create!(name: 'banana tree', description: 'is a tree', days_to_harvest: 17)

    plot_1.plants << plant_1
    plot_1.plants << plant_3

    plot_2.plants << plant_2
    plot_2.plants << plant_3

    plot_3.plants << plant_4

    expect(garden.plants_with_short_harvest_times).to eq([plant_1, plant_3])

  end
end
