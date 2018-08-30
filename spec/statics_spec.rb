# frozen_string_literal: true

RSpec.describe Statics do
  it "has a version number" do
    expect(Statics::VERSION).not_to be nil
  end
end
