module Surveyable::RespondableHelper
  def completed_by_id
    if current_user
      current_user.id
    else
      (@response.respondable_type.to_s == "User") ? @response.respondable_id : nil
    end
  end

  def respondable_form_for(respondable)
    surveys = Surveyable::Survey.enabled
    response = Surveyable::Response.new

    if surveys.any?
      form_for(response) do |f|
        concat f.hidden_field :respondable_id, value: respondable.id
        concat f.hidden_field :respondable_type, value: respondable.class.to_s
        concat f.collection_select :survey_id, surveys, :id, :title
        concat f.submit 'Send the survey', name: :email_survey, class: 'send-survey-submit'
        concat ' or '
        concat f.submit 'Complete the survey', name: :answer_survey, class: 'send-survey-submit'
      end
    else
      content_tag(:p, 'No surveys created')
    end
  end

  def render_answers_for(question)
    case question.field_type.to_sym
    when :text_field
      render_text_field(question)
    when :text_area_field
      render_text_area_field(question)
    when :select_field
      render_select_field(question)
    when :radio_button_field
      render_radio_button_field(question)
    when :check_box_field
      render_check_box_field(question)
    when :date_field
      render_date_field(question)
    end
  end

  private

  def render_text_field(question)
    text_field_tag "questions[#{question.id}]", nil, required: question.required
  end

  def render_text_area_field(question)
    text_area_tag "questions[#{question.id}]", nil, required: question.required
  end

  def render_select_field(question)
    content_tag :div do
      select_tag "questions[#{question.id}]", options_for_select(question.answers.collect { |a| [a.content, a.id] }), required: question.required
    end
  end

  def render_radio_button_field(question)
    radio_buttons = ''

    question.answers.each do |answer|
      radio_button = radio_button_tag("questions[#{question.id}]", answer.id, false, required: question.required)
      label = label_tag("questions_#{question.id}_#{answer.id}", answer.content)

      radio_buttons += content_tag(:li, radio_button + label, class: 'inline-list-item')
    end

    radio_buttons.html_safe
  end

  def render_check_box_field(question)
    checkboxes = ''

    question.answers.each do |answer|
      label = label_tag("questions_#{question.id}_#{answer.content}", answer.content)
      checkbox = check_box_tag("questions[#{question.id}][]", answer.id, false, id: "questions_#{question.id}_#{answer.content}")

      checkboxes += content_tag(:li, checkbox + label, class: 'inline-list-item')
    end

    checkboxes.html_safe
  end

  def render_date_field(question)
    text_field_tag "questions[#{question.id}]", '', { class: 'survey_date', required: question.required }
  end
end
