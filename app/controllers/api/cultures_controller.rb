class Api::CulturesController < ApplicationController
  before_action :set_culture, only: [:show, :update, :destroy]

  
  def index
    @cultures = policy_scope(Culture)
    render json: @cultures, include: :locations
  end

  def show
   authorize @cultures
    render json: @cultures, include: :locations
  end

  def create
   @culture = Culture.create create_params
    authorize @culture
  end 

  def update
    authorize @culture
    @culture.update! update_params

    # authorize @culture
  end

  private

  def set_culture 
    @culture = Culture.find params[:id]
     authorize @culture
  end

  def create_params
    params.require(:culture).permit(
      :id,
      :name,
      :description,
      :start_date,
      :end_date,
      :source,
      locations_attributes: [:latitude, :longitude]
    )
  end
  def update_params
    params.require(:culture).permit(
      :description,
      :start_date,
      :end_date,
      :source,
      locations_attributes: [:latitude, :longitude]
    )
  end
end
