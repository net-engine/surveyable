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
    filters = params.fetch(:filters, {})
    Surveyable.report_filter_class.filter(filters.merge(current_user: current_user))
  end

  def question_ids
    questions = @survey.questions.scoped
    questions = questions.where(field_type: Surveyable::Question::TEXT_TYPES) if params[:filters][:view_type] == 'text'
    questions = questions.where(field_type: Surveyable::Question::GRAPH_TYPES) if params[:filters][:view_type] == 'graph'
    questions.pluck(:id)
  end
end
