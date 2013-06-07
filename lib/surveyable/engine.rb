module Surveyable
  class Engine < ::Rails::Engine
    require 'jquery-rails'
    require 'jquery-ui-rails'

    config.generators do |g|
      g.test_framework :rspec, view_specs: false
    end
  end
end
