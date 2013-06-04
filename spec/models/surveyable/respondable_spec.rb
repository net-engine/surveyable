require 'spec_helper'

describe Surveyable::Respondable do
  # Person comes from spec/dummy.
  before { Person.send(:include, Surveyable::Respondable) }
  subject { Person.new }

  it { should have_many(:responses).class_name('Surveyable::Response') }
end
