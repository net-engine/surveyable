require "spec_helper"

describe Surveyable::QuestionsController do
  let(:question) { create(:question) }

  describe "GET reports" do
    it "calls Surveyable::Report.build" do
      Surveyable::Report.should_receive(:build).with(question: question, current_user: nil, filters: { 'nation_id' => '1' })

      get :reports, id: question.id, filter: { nation_id: 1 }
    end
  end
end

