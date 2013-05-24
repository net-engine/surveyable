require 'spec_helper'

describe Surveyable::Responseable do
  # Person comes from spec/dummy.
  before { Person.send(:include, Surveyable::Responseable) }
  subject { Person.new }

  it { should have_many(:responses).class_name('Surveyable::Response') }
end
