module Surveyable
  class Question < ActiveRecord::Base
    FIELD_TYPES = [
      ['Text Field', :text_field],
      ['Text Area Field', :text_area_field],
      ['Select Field', :select_field],
      ['Radio Button Field', :radio_button_field],
      ['Check Box Field', :check_box_field],
      ['Date Field', :date_field]
    ]

    has_many :answers, dependent: :destroy
    belongs_to :survey

    validates :content, :field_type, presence: true

    attr_accessible :content, :field_type, :answers_attributes

    accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: lambda { |a| a[:content].blank? }
  end
end
