Rails.application.routes.draw do
  namespace :surveyable do
    resources :surveys
    resources :responses
  end

  get '/surveys/:access_token' => 'surveyable/respondable#show', as: :response_survey
  post '/surveys/:access_token' => 'surveyable/respondable#complete', as: :submit_response
end
