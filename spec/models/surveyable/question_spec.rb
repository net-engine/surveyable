require 'spec_helper'

module Surveyable
  describe Question do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:field_type) }
    it { should belong_to(:survey) }
    it { should have_many(:answers).dependent(:destroy) }
    it { should accept_nested_attributes_for(:answers).allow_destroy(true) }

    %w( content field_type survey answers_attributes ).each do |attr|
      it { should allow_mass_assignment_of(attr.to_sym) }
    end
  end
end
