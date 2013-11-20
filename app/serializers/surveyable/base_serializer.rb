module Surveyable
  class BaseSerializer < ActiveModel::Serializer
    def csv_headers
      _attributes.keys.to_csv
    end

    def to_csv
      attributes.values.to_csv
    end
  end
end
