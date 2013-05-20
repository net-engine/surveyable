require 'spec_helper'

module Surveyable
  describe Survey do
    it { should validate_presence_of(:title) }
  end
end
