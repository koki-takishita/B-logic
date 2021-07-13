# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GoalDecorator do
  let(:goal) { Goal.new.extend GoalDecorator }
  subject { goal }
  it { should be_a Goal }
end
