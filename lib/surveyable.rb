require 'active_support/core_ext/kernel/singleton_class'
require "surveyable/engine"

module Surveyable
  mattr_accessor :user_class, :application_controller_class

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

    def user_class
      if @@user_class.is_a?(Class)
        raise "You cannot set Surveyable.user_class to be a class. Please use a string instead.\n\n "
      elsif @@user_class.is_a?(String)
        @@user_class.constantize
      else
        User
      end
    end
  end
end
