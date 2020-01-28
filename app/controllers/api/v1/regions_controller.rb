class Api::V1::RegionsController < ApplicationController
  before_action :load_service_and_region

  def show_region_prices
    @products = @region.products
  end

  private

  def load_service_and_region
    @service = Service.find_by(code: params[:service_code])
    return render status: :not_found, json: { errors: { base: I18n.t('activerecord.errors.models.service.not_found') } } unless @service
    @region = @service.regions.find_by(location: params[:location])
    return render status: :not_found, json: { errors: { base: I18n.t('activerecord.errors.models.region.not_found') } } unless @region
  end
end