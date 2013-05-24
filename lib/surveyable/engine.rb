module Surveyable
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework :rspec, view_specs: false
    end

    initializer 'responseable class patch' do
      Surveyable.responseable_class.send(:include, Surveyable::Responseable) if Surveyable.responseable_class
    end
  end
end
