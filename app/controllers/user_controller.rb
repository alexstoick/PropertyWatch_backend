class UserController < ApplicationController
  def show
  	user = User.find(params[:id])
  	render :json => user.to_json( :only => :id , include: { :zones => { only: [:postcode,:id] } } )
  end

  def create
  	render json: { "success" => true }
  end

  def update

  	user = User.find(params[:id])
  	new_zone = Zone.find_or_create_by( postcode: params[:zone])

  	userWatchZone = UserWatchZone.where( user_id: params[:id] , zone_id: new_zone.id ).first_or_create

  	render :json => user
  end
end
