require 'spec_helper'

module Surveyable
  describe Survey do
    it { should validate_presence_of(:title) }
    it { should have_many(:questions).dependent(:destroy) }
  end
end
