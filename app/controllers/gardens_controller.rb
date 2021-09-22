class GardensController < ApplicationController

  def show
    garden = Garden.find(params[:id])
    @plants_distinct_short_harvest_time = garden.plants_with_short_harvest_times
  end

end
