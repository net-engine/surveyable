require 'spec_helper'

module Surveyable
  describe Response do
    it { should belong_to(:survey) }
    it { should belong_to(:responseable) }
    it { should have_many(:response_answers) }
    it { should validate_presence_of(:survey) }

    %w( survey responseable responseable_id responseable_type ).each do |attr|
      it { should allow_mass_assignment_of(attr.to_sym) }
    end

    describe "#generate_token" do
      let(:survey) { create(:survey) }

      it "creates token before create" do
        response = described_class.create(survey: survey)

        response.access_token.should_not be_blank
      end
    end

    describe "#completed?" do
      context "when completed_at is null" do
        let(:response) { build_stubbed(:response, completed_at: nil) }

        it "returns false" do
          response.should_not be_completed
        end
      end

      context "when completed_at is not null" do
        let(:response) { build_stubbed(:response, completed_at: Time.now) }

        it "returns true" do
          response.should be_completed
        end
      end
    end
  end
end
