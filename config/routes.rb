Rails.application.routes.draw do
  namespace :surveyable do
    resources :surveys
  end

  get '/surveys/:access_token' => 'surveyable/responses#show'
  post '/surveys/:access_token' => 'surveyable/responses#create', as: :submit_survey
end
