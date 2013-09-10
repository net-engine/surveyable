require 'spec_helper'

module Surveyable
  describe Answer do
    it { should have_many(:response_answers) }
    it { should belong_to(:question) }
    it { should validate_presence_of(:content) }

    it "is possible to have a valid answer without score" do
      answer = build(:answer)
      answer.should be_valid
    end

    it "invalidates an answer with a score below 0" do
      answer = build(:answer, score: -5)
      answer.should_not be_valid
    end

    it "invalidates an answer with a score greater than 100" do
      answer = build(:answer, score: 101)
      answer.should_not be_valid
    end

    it "validates an answer with a score within 0 than 100" do
      answer = build(:answer, score: 100)
      answer.should be_valid

      answer = build(:answer, score: 0)
      answer.should be_valid

      answer = build(:answer, score: 50)
      answer.should be_valid
    end
  end
end
