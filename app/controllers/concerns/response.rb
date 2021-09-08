module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def json_error_response(object, status = :bad_request)
    render json: { error: object, status: status.to_s.gsub('_', ' ').titleize, code: Rack::Utils::SYMBOL_TO_STATUS_CODE[status] }, status: status
  end
end
