# frozen_string_literal: true

require "rails_helper"
require "pundit/rspec"
require "webmock/rspec"
require "rspec/json_expectations"

RSpec::Matchers.define_negated_matcher :not_change, :change
