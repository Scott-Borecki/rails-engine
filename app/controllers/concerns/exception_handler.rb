module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    # Raised when Active Record cannot find a record by given id or set of ids.
    # TODO: Fix errors so it can return multiple errors as elements of an array.
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response(
        {
          message: 'your query could not be completed',
          errors: [e.message]
        },
        :not_found
      )
    end

    # Raised by ActiveRecord::Base#save! and ActiveRecord::Base#create! when
    #   the record is invalid
    # TODO: Fix errors so it can return multiple errors as elements of an array.
    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response(
        {
          message: e.message,
          errors: [e.message]
        },
        :unprocessable_entity
      )
    end
  end
end
