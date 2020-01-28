class Api::V1::RegionsController < ApplicationController
  before_action :load_service_and_region

  def show_region_prices
    @products = if params[:date].present?
                  date = validate_and_parse_date
                  @region.products.filter_with_date(date) if date
                else
                  @region.products
                end
  end

  private

  def validate_and_parse_date
      parsed_date = Time.zone.parse(params[:date]) rescue nil
      if parsed_date.nil?
        render status: :unprocessable_entity, json: { errors: { base: I18n.t('custom.errors.controllers.params.date') } }
        return nil
      end
      parsed_date
  end

  def load_service_and_region
    @service = Service.find_by(code: params[:service_code])
    return render status: :not_found, json: { errors: { base: I18n.t('activerecord.errors.models.service.not_found') } } unless @service
    @region = @service.regions.find_by(location: params[:location])
    return render status: :not_found, json: { errors: { base: I18n.t('activerecord.errors.models.region.not_found') } } unless @region
  end
end