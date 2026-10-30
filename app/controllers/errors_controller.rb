class ErrorsController < ActionController::Base
  layout "application"

  def not_found
    render template: "errors/not_found", formats: [:html], status: :not_found
  end
end
