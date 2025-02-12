require "rails_helper"

RSpec.describe 'plot index page' do
   it 'story 1' do
     garden = Garden.create!(name: 'awesome space', organic: true)
     plot_1 = garden.plots.create!(number: 35, size: 'Bigly', direction: 'up')
     plot_2 = garden.plots.create!(number: 20, size: 'Smally', direction: 'down')

     plant_1 = Plant.create!(name: 'shrubbery', description: 'is in awfully high demand', days_to_harvest: 200)
     plant_2 = Plant.create!(name: 'bush', description: 'is not in high demand', days_to_harvest: 50)
     plant_3 = Plant.create!(name: 'apple tree', description: 'is a tree', days_to_harvest: 175)

     plot_1.plants << plant_1
     plot_1.plants << plant_3

     plot_2.plants << plant_2
     plot_2.plants << plant_3

     visit '/plots'

     expect(page).to have_content(plot_1.number)
     expect(page).to have_content(plot_2.number)

     within("##{plot_1.number}-plants") do
       expect(page).to have_content(plant_1.name)
       expect(page).to have_content(plant_3.name)
       expect(page).to_not have_content(plant_2.name)
     end

     within("##{plot_2.number}-plants") do
       expect(page).to have_content(plant_2.name)
       expect(page).to have_content(plant_3.name)
       expect(page).to_not have_content(plant_1.name)
     end
   end

   it 'story 2' do
     garden = Garden.create!(name: 'awesome space', organic: true)
     plot_1 = garden.plots.create!(number: 35, size: 'Bigly', direction: 'up')
     plot_2 = garden.plots.create!(number: 20, size: 'Smally', direction: 'down')

     plant_1 = Plant.create!(name: 'shrubbery', description: 'is in awfully high demand', days_to_harvest: 200)
     plant_2 = Plant.create!(name: 'bush', description: 'is not in high demand', days_to_harvest: 50)
     plant_3 = Plant.create!(name: 'apple tree', description: 'is a tree', days_to_harvest: 175)

     plot_1.plants << plant_1
     plot_1.plants << plant_3

     plot_2.plants << plant_2
     plot_2.plants << plant_3

     visit plots_path

     within("##{plot_1.number}-plants") do
       expect(page).to have_content(plant_3.name)
       expect(page).to have_button("remove #{plant_3.name} from plot")
       click_button "remove #{plant_3.name} from plot"
     end

     expect(current_path).to eq(plots_path)

     within("##{plot_1.number}-plants") do
       expect(page).to_not have_content(plant_3.name)
     end

     within("##{plot_2.number}-plants") do
       expect(page).to have_content(plant_3.name)
     end
   end
end
