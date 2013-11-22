module Surveyable
  class ResponsesFilter
    def self.filter(options = {})
      new(options).filter
    end

    def initialize(options = {})
      @options = options
    end

    def filter
      {}
    end
  end
end

