class Surveyable::SurveyMailer < ActionMailer::Base
  default from: "info@fls.com"

  def invitation(response)
    @response = response
    @survey = response.survey

    mail to: response.respondable.email,
         subject: "You've been invited to respond #{@survey.title}"
  end
end
