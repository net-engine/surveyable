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
        csv << serializer.csv_headers
        csv << serializer.to_csv
      end
    end

    private

    def serializer
      @serializer ||= csv_serializer.new(object: object, response_ids: response_ids)
    end
  end
end
