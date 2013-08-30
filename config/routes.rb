Rails.application.routes.draw do
  namespace :surveyable do
    resources :surveys
    resources :responses
    resources :questions, only: [] do
      get 'reports', on: :member
    end
  end

  get '/surveys/:access_token' => 'surveyable/respondable#show', as: :response_survey
  post '/surveys/:access_token' => 'surveyable/respondable#complete', as: :submit_response
end
