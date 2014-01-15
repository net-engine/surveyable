module Surveyable
  module CSV
    class SurveySerializer
      attr_reader :survey, :response_ids, :question_ids

      def initialize(options = {})
        @survey       = options[:object]
        @response_ids = options[:response_ids]
        @question_ids = options[:question_ids]
      end

      def csv_headers
        ["Subject", "Completed Date", *survey.questions.where(id: question_ids).pluck(:content)].to_csv
      end

      def to_csv
        String.new.tap do |csv|
          Surveyable::Response.where('completed_at IS NOT NULL').where(id: response_ids).all.each do |response|
            response_serializer = ResponseSerializer.new(response: response,
                                                         question_ids: question_ids)
            csv << response_serializer.to_csv
          end
        end
      end
    end
  end
end
