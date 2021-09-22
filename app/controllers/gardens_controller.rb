class GardensController < ApplicationController

  def show
    garden = Garden.find(params[:id])
    @plants_ordered = garden.order_by_occurrance
  end

end
