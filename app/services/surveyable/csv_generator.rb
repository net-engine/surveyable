module Surveyable
  class CsvGenerator
    attr_reader :csv_serializer, :filename, :collection

    def initialize(options = {})
      @csv_serializer = options[:csv_serializer]
      @filename       = options[:filename] || 'survey_csv_export'
      @collection     = options[:collection]
    end

    def response
      String.new.tap do |csv|
        csv << add_headers
        csv << add_body
      end
    end

    private

    def add_headers
      csv_serializer.new(nil).csv_headers
    end

    def add_body
      if collection.is_a?(Array)
        collection.inject('') do |csv, object|
          csv << csv_serializer.new(object).to_csv
        end
      else
        csv_serializer.new(collection).to_csv
      end
    end
  end
end
