class ApplicationController < ActionController::API
  include Pundit

  before_action :authorize_action!
  after_action :verify_authorized
  before_action :set_current_user

  rescue_from BaseError, MultiError, with: :render_errors

  rescue_from ActiveModel::ValidationError do |exception|
    render_errors(Model::ValidationError.new(exception.model.errors, 422))
  end

  rescue_from ActiveRecord::RecordInvalid do |invalid|
    render_errors(Model::ValidationError.new(invalid.record.errors))
  end

  rescue_from Pundit::NotAuthorizedError do
    render_errors(ForbiddenError.new)
  end

  rescue_from ActiveRecord::RecordNotFound do
    render_errors(NotFoundError.new)
  end

  private

  def render_errors(exception)
    render(
        json: { errors: [exception.jsonapi_hash].flatten },
        status: exception.http
    )
  end

  def authorize_action!
    authorize self
  end

  def set_current_user
    Current.user = current_user
  end
end
