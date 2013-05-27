require 'spec_helper'

module Surveyable
  describe SurveysController do
    let(:survey) { create(:survey) }

    describe "GET edit" do
      context "when it has been answered already" do
        it "sets flash notice" do
          Survey.any_instance.stub(:has_been_answered?).and_return(true)

          get :edit, id: survey.id

          flash[:notice].should == "This survey has already been answered. It cannot be edited."
        end
      end
    end

    describe "PUT update" do
      context "when it has been answered already" do
        before { Survey.any_instance.stub(:has_been_answered?).and_return(true) }

        it "redirects to index" do
          put :update, id: survey.id

          response.should redirect_to surveyable_surveys_path
        end
      end
    end
  end
end
