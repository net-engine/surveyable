ActionController::Renderers.add :csv do |object, options|
  generator = Surveyable::CsvGenerator.new(options.merge(object: object))

  response = generator.response
  filename = generator.filename

  headers['Content-Disposition'] = "inline; filename=#{filename}.csv"

  self.response_body = response
end
