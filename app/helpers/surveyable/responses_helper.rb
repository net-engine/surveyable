module Surveyable::ResponsesHelper
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
    text_field_tag "questions[#{question.id}]"
  end

  def render_text_area_field(question)
    text_area_tag "questions[#{question.id}]"
  end

  def render_select_field(question)
    content_tag :div do
      select_tag "questions[#{question.id}]", options_for_select(question.answers.collect { |a| [a.content, a.id] })
    end
  end

  def render_radio_button_field(question)
    radio_buttons = ''

    question.answers.each do |answer|
      radio_button = radio_button_tag("questions[#{question.id}]", answer.id)
      label = label_tag("questions_#{question.id}_#{answer.id}", answer.content)

      radio_buttons += radio_button + label
    end

    radio_buttons.html_safe
  end

  def render_check_box_field(question)
    checkboxes = ''

    question.answers.each do |answer|
      label = label_tag("questions_#{question.id}_#{answer.content}", answer.content)
      checkbox = check_box_tag("questions[#{question.id}][]", answer.id, false, id: "questions_#{question.id}_#{answer.content}")

      checkboxes += checkbox + label
    end

    checkboxes.html_safe
  end

  def render_date_field(question)
    date_select "questions[#{question.id}]", '', class: 'survey_date'
  end
end
