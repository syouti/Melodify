class ApplicationController < ActionController::Base
  before_action :debug_output

  private

  def debug_output
    Rails.logger.debug "======= Debug Info ======="
    Rails.logger.debug "Controller: #{params[:controller]}"
    Rails.logger.debug "Action: #{params[:action]}"
    Rails.logger.debug "Parameters: #{params.inspect}"
    Rails.logger.debug "=========================="
  end
end
