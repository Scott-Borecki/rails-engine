class ApplicationController < ActionController::API
  include Convertable
  include ExceptionHandler
  include Response
end
