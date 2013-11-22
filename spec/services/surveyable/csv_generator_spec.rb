require 'csv'
require_relative '../../../app/services/surveyable/csv_generator'

class FakeObject
  attr_accessor :foo, :bar

  def initialize(args = {})
    @foo = args[:foo]
    @bar = args[:bar]
  end
end

class FakeSerializer
  attr_reader :object

  def initialize(options = {})
    @object = options[:object]
  end

  def csv_headers
    [:foo, :bar].to_csv
  end

  def to_csv
    [object.foo, object.bar].to_csv
  end
end

describe Surveyable::CsvGenerator do
  let(:object) { FakeObject.new(foo: 1, bar: 2) }
  let(:serializer) { FakeSerializer }

  describe "#response" do
    it "generates csv using serializer" do
      csv_generator = described_class.new(csv_serializer: serializer, object: object, filename: 'my_csv')
      csv_generator.response.should == "foo,bar\n1,2\n"
    end
  end

  describe "#filename" do
    context "when filename is passed as argument" do
      it "returns filename" do
        described_class.new(filename: 'my_cool_csv').filename.should == 'my_cool_csv'
      end
    end

    context "when filename is not passed as argument" do
      it "returns default filename" do
        described_class.new.filename.should == 'survey_csv_export'
      end
    end
  end
end
