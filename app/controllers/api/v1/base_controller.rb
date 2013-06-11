class Api::V1::BaseController < ActionController::Base
  before_action :restrict_access
  respond_to :json

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      token == "abc123"
    end
  end
end
