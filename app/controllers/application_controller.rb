class ApplicationController < ActionController::Base
  before_action :set_current_organization

  helper_method :current_organization
  private

  def set_current_organization
  @current_organization = Organization.find_by!(subdomain: request.subdomain)
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url(subdomain: nil), alert: "Organization not found"
  end

  def current_organization
    @current_organization
  end
end
