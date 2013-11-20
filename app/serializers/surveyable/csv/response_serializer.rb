module Surveyable
  module CSV
    class ResponseSerializer
      attr_reader :response, :question_ids

      def initialize(options = {})
        @response     = options[:response]
        @question_ids = options[:question_ids]
      end

      def to_csv
        csv = []
        csv << response.respondable.to_s

        response_answers_grouped.each do |question_id, response_answers|
          csv << response_answers.map(&:to_s).join(";")
        end

        csv.to_csv
      end

      private

      def response_answers_grouped
        response.response_answers.
          joins(:question).
          where(question_id: question_ids).
          order('questions.position ASC').
          group_by(&:question_id)
      end
    end
  end
end

