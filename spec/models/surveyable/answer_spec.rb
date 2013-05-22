require 'spec_helper'

module Surveyable
  describe Answer do
    it { should belong_to(:question) }
    it { should validate_presence_of(:content) }

    %w( content position ).each do |attr|
      it { should allow_mass_assignment_of(attr.to_sym) }
    end
  end
end
