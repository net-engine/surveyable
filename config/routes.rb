Rails.application.routes.draw do
  get '/surveys/:access_token' => 'responses#show'
  post '/surveys/:access_token' => 'responses#show', as: :submit_survey

  namespace :surveyable do
    resources :surveys
  end
end
