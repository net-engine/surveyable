require 'spec_helper'

module Surveyable
  describe Response do
    it { should belong_to(:survey) }
    it { should belong_to(:responseable) }
    it { should have_many(:response_answers) }
  end
end
