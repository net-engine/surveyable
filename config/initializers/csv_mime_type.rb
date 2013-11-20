ActionController::Renderers.add :csv do |collection, options|
  generator = Surveyable::CsvGenerator.new(options.merge(collection: collection))

  response = generator.response
  filename = generator.filename

  headers['Content-Disposition'] = "inline; filename=#{filename}.csv"

  self.response_body = response
end
