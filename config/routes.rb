Surveyable::Engine.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :surveys, except: [:new, :edit]
    end
  end
end
