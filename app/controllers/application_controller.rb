class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def render_command_result(result, **options)
    case result
    in [:success, ApplicationRecord => record] then render json: record, status: :ok, **options
    in [:success, String => data, String => filename] then send_data(data, filename:)
    in [:success, String => data, String => filename, Hash => opts] then send_data(data, filename:, **opts)
    in [:success, Hash => data] then render json: data, status: :ok, **options
    in [:created, ApplicationRecord => record] then render json: record, status: :created, **options
    in [:failure, Hash => errors] then render json: { errors: }, status: :unprocessable_entity
    end
  end
end
