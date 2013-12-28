class ZoneController < ApplicationController

  # GET zone/:id
  def show
  	zone = Zone.find(params[:id])
  	render json: zone.to_json( only: [:postcode, :id] , include: { watchers: { only: :id } } )
  end

  #GET zone/:id/properties
  def showProperties
  	zone = Zone.find(params[:id])
  	render json: zone.to_json( only: [:postcode, :id] , include: :properties )
  end
end
