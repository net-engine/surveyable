require 'active_support/core_ext/kernel/singleton_class'
require 'surveyable/engine'
require 'strong_parameters'
require 'acts_as_list'

module Surveyable
  mattr_accessor :application_controller_class, :invite_respondable_via_email, :from_email

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

    def invite_respondable_via_email
      !!@@invite_respondable_via_email
    end

    def from_email
      @@from_email || 'no-reply@surveyable.com'
    end
  end
end
