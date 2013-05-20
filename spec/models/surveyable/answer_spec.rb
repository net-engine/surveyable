require 'spec_helper'

module Surveyable
  describe Answer do
    it { should belong_to(:question) }
    it { should validate_presence_of(:question_id) }
    it { should validate_presence_of(:content) }
  end
end
