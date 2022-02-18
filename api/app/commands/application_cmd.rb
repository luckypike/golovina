# frozen_string_literal: true

class ApplicationCmd < Actor
  private

  def validate_contract!(contract, params)
    params = params.to_unsafe_h if params.is_a?(ActionController::Parameters)
    fail!(http_status_code: :unprocessable_entity) if params.blank?
    result = contract.new.call(**params)
    fail!(errors: result.errors.to_hash, http_status_code: :unprocessable_entity) unless result.success?

    result.to_h
  end

  def validate_entity!(entity)
    return if entity.valid?

    fail!(errors: entity.errors.to_hash, http_status_code: :unprocessable_entity)
  end
end
