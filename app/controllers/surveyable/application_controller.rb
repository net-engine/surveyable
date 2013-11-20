class Surveyable::ApplicationController < Surveyable.application_controller_class
  helper_method :current_user

  def current_user
    super
  rescue
    nil
  end

  private

  def visible_response_ids
    Surveyable::Response.where(visible_respondable_args).pluck(:id).uniq
  end

  def visible_respondable_args
    filters = params.fetch(:filter, {})
    Surveyable.report_filter_class.filter(filters.merge(current_user: current_user))
  end
end
