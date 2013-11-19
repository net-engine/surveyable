require 'active_support/core_ext/kernel/singleton_class'
require 'surveyable/engine'
require 'acts_as_list'

module Surveyable
  mattr_accessor :application_controller_class, :from_email, :report_filter_class

  class << self
    def application_controller_class
      if @@application_controller_class.is_a?(Class)
        raise "You cannot set Surveyable.application_controller_class to be a class. Please use a string instead.\n\n "
      elsif @@application_controller_class.is_a?(String)
        @@application_controller_class.constantize
      else
        ActionController::Base
      end
    end

    def report_filter_class
      if @@report_filter_class.is_a?(Class)
        raise "You cannot set Surveyable.report_filter_class to be a class. Please use a string instead.\n\n "
      elsif @@report_filter_class.is_a?(String)
        @@report_filter_class.constantize
      else
        Surveyable::ResponsesFilter
      end
    end

    def from_email
      @@from_email || 'no-reply@surveyable.com'
    end
  end
end
