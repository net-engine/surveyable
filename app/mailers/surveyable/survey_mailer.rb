class Surveyable::SurveyMailer < ActionMailer::Base
  default from: Surveyable.from_email

  def invitation(response, email)
    @response = response
    @survey = response.survey

    mail to: email,
         subject: "You've been invited to respond #{@survey.title}"
  end
end
