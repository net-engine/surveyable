module Surveyable
  class Question < ActiveRecord::Base
    acts_as_list scope: :survey_id

    FIELD_TYPES = [
      ['Text Field', :text_field],
      ['Text Area Field', :text_area_field],
      ['Select Field', :select_field],
      ['Radio Button Field', :radio_button_field],
      ['Check Box Field', :check_box_field],
      ['Date Field', :date_field],
      ['Rank Field', :rank_field]
    ]

    REPORTABLE_TYPES = ["select_field", "radio_button_field", "check_box_field"]

    has_many :answers, dependent: :destroy, order: :position

    belongs_to :survey

    validates :content, :field_type, presence: true
    validates :minimum, :maximum, presence: true, if: proc { |question| question.field_type == :rank_field }
    validate :maximum_must_be_greater_than_minimum, if: proc { |question| question.field_type == :rank_field }

    accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: lambda { |a| a[:content].blank? }

    # When applicable, provides an array such as this one
    # [{:text=>"Awesome", :occurrence=>2, :percentage=>66.67, :id=>1},
    #  {:text=>"Okay", :occurrence=>1, :percentage=>33.33, :id=>4}]
    def reports
      if self.reportable?
        distribution      = compute_distribution
        total_occurrences = total_occurrences_in_distribution(distribution)

        distribution.each do |answer|
          answer[:percentage] = ((answer[:occurrence].to_f / total_occurrences) * 100).round(2)
        end

        distribution.sort_by { |answer| -(answer[:percentage]) }
      else
        "N/A"
      end
    end

    def reportable?
      REPORTABLE_TYPES.include?(field_type)
    end

    private

    def total_occurrences_in_distribution(distribution)
      distribution.sum { |answer| answer[:occurrence] }
    end

    def compute_distribution
      distribution = []
      self.answers.each do |answer|
        results = { occurrence: answer.response_answers.count, text: answer.content, id: answer.id }
        distribution << results if results[:occurrence] > 0
      end

      distribution
    end

    def maximum_must_be_greater_than_minimum
      if maximum && minimum && (maximum < minimum)
        errors.add(:maximum, "Maximum must be greater than minimum")
      end
    end
  end
end
