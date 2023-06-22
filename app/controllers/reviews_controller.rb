class ReviewsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  wrap_parameters format: []

  def index
    if params[:dog_house_id]
      dog_house = DogHouse.find(params[:dog_house_id])
      reviews = dog_house.reviews
    else
      reviews = Review.all
    end
    render json: reviews, include: {dog_house: {except: [:updated_at, :created_at]} }, except: [:created_at, :updated_at, :dog_house_id], status: :ok
  end

  def show
    review = find_review
    render json: review, include: {dog_house: {except: [:updated_at, :created_at]} }, except: [:created_at, :updated_at, :dog_house_id], status: :ok
  end

  def create
    review = Review.create(review_params)
    render json: review, except: [:created_at, :updated_at, :dog_house_id], status: :created
  end

  private

  def find_review
    Review.find(params[:id])
  end

  def render_not_found_response
    render json: { error: "Review not found" }, status: :not_found
  end

  def review_params
    params.permit(:user, :comment, :rating)
  end

end
