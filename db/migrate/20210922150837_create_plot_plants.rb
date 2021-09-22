class CreatePlotPlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plot_plants do |t|
      t.references :plant
      t.references :plot
    end
  end
end
