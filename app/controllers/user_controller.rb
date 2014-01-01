class UserController < ApplicationController

  #GET user/:id
  def show
  	user = User.find(params[:id])
    user.zones.map(&method(:callUpdateProperties))
  	render json: user.to_json( only: :id , include: { zones: { only: [:postcode,:id] } } )
  end

  #POST user/
  def create
  	user = User.new( deviceToken: params[:deviceToken], deviceType: params[:deviceType])
  	render json: user.to_json( :only => :id )
  end

  #PATCH user/:id
  def update

  	user = User.find(params[:id])
  	new_zone = Zone.where( postcode: params[:zone]).first_or_create
    new_zone.processProperties
  	userWatchZone = UserWatchZone.where( user_id: params[:id] , zone_id: new_zone.id ).first_or_create

  	render json: user.to_json( only: :id , include: { zones: { only: [:postcode,:id] } } )
  end

  #DELETE user/:id
  def destroy
    user = User.find(params[:id])
    zone = Zone.find(params[:zone])

    userWatchZone = UserWatchZone.where( user_id: user.id , zone_id: zone.id).first

    userWatchZone.destroy

    if ( zone.watchers.count == 0 )
      #the current user is the only watcher therefore we can delete it
      zone.destroy
    end

    render json: user.to_json( only: :id , include: { zones: { only: [:postcode,:id] } } )
  end

  private
    def callUpdateProperties(zone)
      zone.processProperties
    end
end
