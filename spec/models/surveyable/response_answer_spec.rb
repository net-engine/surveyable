require 'spec_helper'

module Surveyable
  describe ResponseAnswer do
    it { should belong_to(:response) }
    it { should belong_to(:question) }
    it { should belong_to(:answer) }
    it { should validate_presence_of(:response) }
    it { should validate_presence_of(:question) }

    %w( question_id answer_id free_content ).each do |attr|
      it { should allow_mass_assignment_of(attr.to_sym) }
    end
  end
end
