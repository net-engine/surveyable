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
      distribution         = compute_distribution
      if distribution.kind_of? Hash
        total_occurrences  = total_occurrences_in_distribution(distribution)
        distribution.each do |k, v|
          v[:percentage] = ((v[:occurrence].to_f / total_occurrences) * 100).round(2)
          v[:id]         = k
        end
        return distribution.values.sort_by{|answer| -(answer[:percentage])}
      end
      return "N/A"
    end

    private

    def total_occurrences_in_distribution(distribution)
      distribution.sum{|_,v| v[:occurrence]}
    end

    def compute_distribution
      return "N/A" unless ["select_field", "radio_button_field", "check_box_field"].include? field_type

      ras = ResponseAnswer.where(question_id: self.id)

      distribution = {}
      ras.each do |ra|
        if distribution.has_key? ra.answer_id
          distribution[ra.answer_id][:occurrence] += 1
        else
          distribution[ra.answer_id] = {}
          distribution[ra.answer_id][:text] = ra.answer.content
          distribution[ra.answer_id][:occurrence] = 1
        end
      end
      return distribution
    end

    def maximum_must_be_greater_than_minimum
      if maximum && minimum && (maximum < minimum)
        errors.add(:maximum, "Maximum must be greater than minimum")
      end
    end
  end
end
