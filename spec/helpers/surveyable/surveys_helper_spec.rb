require 'spec_helper'

describe Surveyable::SurveysHelper do
  let(:survey) { create(:survey) }

  before(:each) do
    form_for(survey) { |form| @form = form }
  end

  describe "#link_to_remove_fields" do
    it "returns the appropriate html" do
      expected = "<input id=\"surveyable_survey__destroy\" name=\"surveyable_survey[_destroy]\" type=\"hidden\" value=\"false\" /><a class=\"remove_link\" href=\"#\" onclick=\"remove_fields(this); return false;\">remove</a>"

      helper.link_to_remove_fields('remove', @form).should == expected
    end
  end

  describe "#link_to_add_fields" do
    it "returns the appropriate html" do
      pending
      helper.link_to_add_fields('Add answer', @form, :questions).should match(/add_fields/)
    end
  end
end
