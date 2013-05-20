require 'spec_helper'

module Surveyable
  describe Question do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:field_type) }
    it { should belong_to(:survey) }
  end
end
