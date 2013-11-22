class Surveyable::ApplicationController < Surveyable.application_controller_class
  helper_method :current_user

  def current_user
    super
  rescue
    nil
  end
end
