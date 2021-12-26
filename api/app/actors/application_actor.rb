# frozen_string_literal: true

class ApplicationActor < Actor
  private

  def validate_contract(contract, params)
    result = contract.new.call(*params)
    fail!(errors: result.errors.to_h, http_status_code: :unprocessable_entity) unless result.success?

    result.to_h
  end
end
