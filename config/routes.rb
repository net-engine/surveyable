Rails.application.routes.draw do
  namespace :surveyable do
    resources :surveys, except: :show
    resources :responses
  end

  get '/surveys/:access_token' => 'surveyable/responseable#show'
  post '/surveys/:access_token' => 'surveyable/responseable#complete', as: :submit_response
end
