require "rails_helper"

RSpec.describe 'garden show page' do

  it 'can show all plants no repeats' do
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

    visit garden_path(garden)

    expect(page).to have_content(plant_1.name)
    expect(page).to have_content(plant_2.name)
    expect(page).to have_content(plant_3.name, count: 1)
    expect(page).to_not have_content(plant_4.name)
  end

  it 'can show only short harvest times' do
    garden = Garden.create!(name: 'awesome space', organic: true)
    plot_1 = garden.plots.create!(number: 35, size: 'Bigly', direction: 'up')
    plot_2 = garden.plots.create!(number: 20, size: 'Smally', direction: 'down')

    plant_1 = Plant.create!(name: 'shrubbery', description: 'is in awfully high demand', days_to_harvest: 20)
    plant_2 = Plant.create!(name: 'bush', description: 'is not in high demand', days_to_harvest: 50)
    plant_3 = Plant.create!(name: 'apple tree', description: 'is a tree', days_to_harvest: 101)

    plot_1.plants << plant_1
    plot_1.plants << plant_3

    plot_2.plants << plant_2
    plot_2.plants << plant_3

    visit garden_path(garden)

    expect(page).to have_content(plant_1.name)
    expect(page).to have_content(plant_2.name)
    expect(page).to_not have_content(plant_3.name)
  end

  it 'can order by number of times planted' do
    garden = Garden.create!(name: 'awesome space', organic: true)
    plot_1 = garden.plots.create!(number: 35, size: 'Bigly', direction: 'up')
    plot_2 = garden.plots.create!(number: 20, size: 'Smally', direction: 'down')

    plant_1 = Plant.create!(name: 'shrubbery', description: 'is in awfully high demand', days_to_harvest: 20)
    plant_2 = Plant.create!(name: 'bush', description: 'is not in high demand', days_to_harvest: 50)
    plant_3 = Plant.create!(name: 'apple tree', description: 'is a tree', days_to_harvest: 99)

    plot_1.plants << plant_1
    plot_1.plants << plant_3

    plot_2.plants << plant_2
    plot_2.plants << plant_3

    visit garden_path(garden)

    expect(plant_3.name).to appear_before(plant_1.name)
    expect(plant_3.name).to appear_before(plant_2.name)
  end
end
