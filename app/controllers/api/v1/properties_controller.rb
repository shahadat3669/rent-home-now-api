class Api::V1::PropertiesController < ApplicationController
  before_action :set_property, only: %i[show update destroy]
  before_action :set_default_response_format
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @properties = Property.includes(:user, :category, :images, :address, :reservation_criteria)
    # render json: @properties, include: %i[user category images address reservation_criteria]
    render json: @properties
  end

  def show
    @property = Property.includes(:user, :category, :images, :address, :reservation_criteria).find(params[:id])
    render json: @property, include: %i[user category images address reservation_criteria]
  end

  def create
    @property = Property.new(property_params)

    if @property.save
      render json: @property, include: %i[user category images address reservation_criteria], status: :created
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  def update
    if @property.update(property_params)
      render json: @property, include: %i[user category images address reservation_criteria]
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @property.destroy
    head :no_content
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(
      :name,
      :description,
      :no_bedrooms,
      :no_baths,
      :no_beds,
      :area,
      :user_id,
      :category_id,
      address_attributes: %i[city state street house_number country zip_code],
      reservation_criteria_attributes: %i[time_period others_fee min_time_period max_guest rate]
    )
  end

  def set_default_response_format
    request.format = :json
  end

  def record_not_found
    render json: { error: 'Record not found', status: :not_found }, status: :not_found
  end
end

# POST /api/v1/properties
#
# {
#   "name": "My Property",
#   "description": "A description of my property",
#   "no_bedrooms": 2,
#   "no_baths": 2,
#   "no_beds": 3,
#   "area": 100,
#   "address_attributes": {
#     "city": "New York",
#     "state": "NY",
#     "street": "123 Main St",
#     "house_number": "Apt 2B",
#     "country": "USA",
#     "zip_code": "10001"
#   },
#   "category_attributes": {
#     "name": "Apartment"
#   },
#   "reservation_criteria_attributes": {
#     "time_period": "Week",
#     "others_fee": 100,
#     "min_time_period": 3,
#     "max_guest": 4,
#     "rate": 200
#   }
# }