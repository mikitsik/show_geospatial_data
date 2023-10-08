class Api::BaseController < ApplicationController
  class Api::InvalidRequestError < StandardError; end

  rescue_from Api::InvalidRequestError do |error|
    render_error(error, :unprocessable_entity)
  end

  rescue_from ActiveRecord::RecordInvalid do |error|
    render_error ErrorSerializer.new(error.record), :unprocessable_entity
  end

  private

  def render_error(error, status)
    render json: {errors: [error.message]}, status: status
  end
end
