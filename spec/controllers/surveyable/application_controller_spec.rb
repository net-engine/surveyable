require "spec_helper"

describe Surveyable::ApplicationController do
  describe "#current_user" do
    it "returns nil" do
      controller.current_user.should be_nil
    end
  end
end

