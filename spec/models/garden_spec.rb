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

  it 'can get all plants and sort by how many plots they are in' do
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

    expect(garden.order_by_occurrance).to eq([plant_3, plant_1])
  end
end


# Extension,
# As a visitor
# When I visit a garden's show page,
# Then I see the list of plants is sorted by the number of plants that appear in any of that garden's plots from most to least
# (Note: you should only make 1 database query to retrieve the sorted list of plants)
