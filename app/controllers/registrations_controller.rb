class RegistrationsController < ApplicationController
  protected

  def after_sign_up_path_for(resource)
    root_path # Or :prefix_to_your_route
  end
end
