class ErrorsController < ActionController::Base
  layout "application"

  def not_found
    render status: :not_found
  end
end
