require 'spec_helper'

describe Surveyable::RespondableHelper do
  describe "#respondable_form_for" do
    let(:user) { mock(:user, id: 7594, class: 'User') }

    context "when there is no survey" do
      it "returns no survey created" do
        helper.respondable_form_for(user).should == '<p>No surveys created</p>'
      end
    end

    context "when there is survey" do
      let!(:survey) { create(:survey) }

      it "returns form to create survey" do
        form_output = helper.respondable_form_for(user)

        form_output.should have_selector('input')
        form_output.should have_selector('select')
        form_output.should have_selector('option', count: 1)
        form_output.should have_selector('option', text: survey.title)
        form_output.should include('7594')
        form_output.should include('User')
        form_output.should include('Send the survey')
        form_output.should include('Complete the survey')
      end
    end
  end

  describe "#render_answers_for" do
    context "when question is text field" do
      let(:question) { build_stubbed(:question, field_type: :text_field) }

      it "renders text field" do
        text_input = helper.render_answers_for(question)

        text_input.should have_selector('input')
        text_input.should include('type="text"')
      end
    end

    context "when question is text area field" do
      let(:question) { build_stubbed(:question, field_type: :text_area_field) }

      it "renders text area field" do
        helper.render_answers_for(question).should have_selector('textarea')
      end
    end

    context "when question is select field" do
      let(:question) { create(:question_with_answers, answers_count: 2, field_type: :select_field) }

      it "renders select field" do
        select_input = helper.render_answers_for(question)

        select_input.should have_selector('select')
        select_input.should have_selector('option', count: 2)

        question.answers.each do |answer|
          select_input.should have_selector('option', text: answer.content)
          select_input.should include(answer.id.to_s)
        end
      end
    end

    context "when question is radio button field" do
      let(:question) { create(:question_with_answers, answers_count: 2, field_type: :radio_button_field) }

      it "renders radio field" do
        radio_input = helper.render_answers_for(question)

        radio_input.should have_selector('input', count: 2)
        radio_input.should include('type="radio"')

        question.answers.each do |answer|
          radio_input.should have_selector('label', text: answer.content)
          radio_input.should include(answer.id.to_s)
        end
      end
    end

    context "when question is checkbox button field" do
      let(:question) { create(:question_with_answers, answers_count: 2, field_type: :check_box_field) }

      it "renders checkbox field" do
        checkbox_input = helper.render_answers_for(question)

        checkbox_input.should have_selector('input', count: 2)
        checkbox_input.should include('type="checkbox"')

        question.answers.each do |answer|
          checkbox_input.should have_selector('label', text: answer.content)
          checkbox_input.should include(answer.id.to_s)
        end
      end
    end

    context "when question is rank field" do
      let(:question) { create(:question, field_type: :rank_field, minimum: 1, maximum: 5) }

      it "renders checkbox field" do
        rank_input = helper.render_answers_for(question)

        rank_input.should have_selector('input', count: 5)
        rank_input.should include('type="radio"')

        (question.minimum..question.maximum).each do |rank|
          rank_input.should have_selector('label', text: rank)
          rank_input.should include(rank.to_s)
        end
      end
    end

    context "when question is date field" do
      let(:question) { build_stubbed(:question, field_type: :date_field) }

      it "renders checkbox field" do
        date_input = helper.render_answers_for(question)

        date_input.should include('survey_date')
      end
    end
  end

  describe "#completed_by_id" do
    context "when current user is present" do
      before { helper.stub(:current_user).and_return(mock(id: 22)) }

      it "returns current user id as completed by" do
        helper.completed_by_id.should == 22
      end
    end

    context "when respondable type is user" do
      before(:each) do
        helper.stub(:current_user).and_return(nil)
        @response = mock(respondable_type: 'User', respondable_id: 10)
      end

      it "returns respondable id" do
        helper.completed_by_id.should == 10
      end
    end

    context "when respondable type is not user" do
      before(:each) do
        helper.stub(:current_user).and_return(nil)
        @response = mock(respondable_type: 'Service', respondable_id: 10)
      end

      it "returns respondable id" do
        helper.completed_by_id.should == nil
      end
    end
  end
end
