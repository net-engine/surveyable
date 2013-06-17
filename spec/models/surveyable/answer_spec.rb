require 'spec_helper'

module Surveyable
  describe Answer do
    it { should belong_to(:question) }
    it { should validate_presence_of(:content) }

    it "is possible to have a valid answer without score" do
      answer = build :answer
      answer.valid?.should == true
    end

    it "invalidates an answer with a score below 0" do
      answer = build :answer, score: -5
      answer.valid?.should == false
    end

    it "invalidates an answer with a score greater than 100" do
      answer = build :answer, score: 101
      answer.valid?.should == false
    end

    it "validates an answer with a score within 0 than 100" do
      answer = build :answer, score: 100
      answer.valid?.should == true
      answer = build :answer, score: 0
      answer.valid?.should == true
      answer = build :answer, score: 50
      answer.valid?.should == true
    end
  end
end
