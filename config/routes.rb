Surveyable::Engine.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :surveys, except: [:new, :edit]
    end
  end

  get '/surveys/:access_token' => 'responses#show'
  post '/surveys/:access_token' => 'responses#show', as: :submit_survey
end
