# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_organization!

  def create
    build_resource(sign_up_params)

    # Scope to subdomain
    resource.organization = current_organization

    resource.save
    yield resource if block_given?

    if resource.persisted?
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  private

  def ensure_organization!
    unless current_organization
      flash[:alert] = "No organization found for this subdomain."
      redirect_to root_url(subdomain: nil)
    end
  end
end
