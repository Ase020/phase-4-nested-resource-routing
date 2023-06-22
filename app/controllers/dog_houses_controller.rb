class DogHousesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    dog_houses = DogHouse.all
    render json: dog_houses, include: {reviews: {except: [:created_at, :updated_at, ]} }, except: [:created_at, :updated_at], status: :ok
  end
  def show
    dog_house = find_dog_house
    render json: dog_house, include: {reviews: {except: [:created_at, :updated_at]} }, except: [:created_at, :updated_at], status: :ok
  end
  

  private

  def find_dog_house
    DogHouse.find(params[:id])
  end

  def render_not_found_response
    render json: { error: "Dog house not found" }, status: :not_found
  end

end
