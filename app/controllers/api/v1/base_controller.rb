class Api::V1::BaseController < ActionController::Base
  before_action :restrict_access
  respond_to :json

  rescue_from ::MultiJson::LoadError do
    respond_with_error!(:malformed_json, status: :bad_request)
  end

  def respond_with_error!(error, options = {})
    status = options.delete(:status) || :bad_request
    location = options.delete(:location) || root_path
    response = ({ error: error, message: t("api.error.#{error}", options.delete(:message_params)) }).merge!(options)
    respond_to do |format|
      format.json { render json: response.to_json, status: status, location: location }
    end
  end

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      token == "abc123"
    end
  end
end
