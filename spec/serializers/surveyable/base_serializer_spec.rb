require 'spec_helper'

class Foo < ActiveRecord::Base
  attr_accessor :bar, :baz

  def initialize(options = {})
    @bar = options[:bar]
    @baz = options[:baz]
  end
end

class Surveyable::FooSerializer < Surveyable::BaseSerializer
  attributes :bar, :baz
end

describe Surveyable::BaseSerializer do
  let(:object) { Foo.new(bar: 10, baz: 20) }
  let(:serializer) { Surveyable::FooSerializer.new(object) }

  describe "#csv_headers" do
    it "returns keys" do
      serializer.csv_headers.should == "bar,baz\n"
    end
  end

  describe "#to_csv" do
    it "returns values" do
      serializer.to_csv.should == "10,20\n"
    end
  end
end
