module Surveyable
  class CsvGenerator
    attr_reader :csv_serializer, :filename, :object, :response_ids

    def initialize(options = {})
      @csv_serializer = options[:csv_serializer]
      @filename       = options[:filename] || 'survey_csv_export'
      @object         = options[:object]
      @response_ids   = options[:response_ids] || []
    end

    def response
      String.new.tap do |csv|
        csv << add_headers
        csv << add_body
      end
    end

    private

    def add_headers
      csv_serializer.new(object: object, response_ids: response_ids).csv_headers
    end

    def add_body
      csv_serializer.new(object: object, response_ids: response_ids).to_csv
    end
  end
end
