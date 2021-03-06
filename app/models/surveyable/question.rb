module Surveyable
  class Question < ActiveRecord::Base
    acts_as_list scope: :survey_id

    FIELD_TYPES = [
      ['Text Field',         :text_field],
      ['Text Area Field',    :text_area_field],
      ['Select Field',       :select_field],
      ['Radio Button Field', :radio_button_field],
      ['Check Box Field',    :check_box_field],
      ['Date Field',         :date_field],
      ['Rank Field',         :rank_field]
    ]

    TEXT_TYPES = %w(text_field text_area_field date_field)
    GRAPH_TYPES = %w(select_field radio_button_field check_box_field rank_field)

    REPORTABLE_TYPES = %w{select_field radio_button_field check_box_field rank_field text_field text_area_field}

    has_many :answers, dependent: :destroy, order: :position
    has_many :response_answers

    belongs_to :survey

    validates :content, :field_type, presence: true
    validates :minimum, :maximum, presence: true,   if: proc { |question| question.field_type == :rank_field }
    validate :maximum_must_be_greater_than_minimum, if: proc { |question| question.field_type == :rank_field }

    accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: lambda { |a| a[:content].blank? }

    def potential_score
      case self.field_type.to_s
      when 'check_box_field'
        answers.pluck(:score).inject(:+) rescue 0
      else
        answers.pluck(:score).max
      end
    end

    def text_answer?
      %w(text_field text_area_field date_field rank_field).include?(field_type.to_s)
    end

    private

    def maximum_must_be_greater_than_minimum
      if maximum && minimum && (maximum < minimum)
        errors.add(:maximum, "Maximum must be greater than minimum")
      end
    end
  end
end
