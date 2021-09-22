class GardensController < ApplicationController

  def show
    garden = Garden.find(params[:id])
    @plants_distinct = garden.distinct_plants
  end

end
