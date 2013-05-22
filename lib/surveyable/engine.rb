module Surveyable
  class Engine < ::Rails::Engine
    isolate_namespace Surveyable

    config.generators do |g|
      g.test_framework :rspec, view_specs: false
    end
  end
end
