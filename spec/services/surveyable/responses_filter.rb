require "spec_helper"

describe Surveyable::ResponsesFilter do
  describe ".filter" do
    it "returns empty hash" do
      described_class.filter.should == {}
    end
  end
end

