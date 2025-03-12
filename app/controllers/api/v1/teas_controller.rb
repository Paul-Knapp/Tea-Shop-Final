class Api::V1::TeasController < ApplicationController
  
  def index
    teas = Tea.all
    render json: TeaSerializer.new(teas).serializable_hash.to_json
  end

  def show
    tea = Tea.find(params[:id])
    render json: TeaSerializer.new(tea).serializable_hash.to_json
  end
end
