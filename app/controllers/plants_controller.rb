class PlantsController < ApplicationController


  def destroy
    plant = Plant.find(params[:id])
    plot_plant = plant.fetch_plot_plant(params[:plot_id])
    plot_plant.destroy
    redirect_to '/plots'
  end
end
