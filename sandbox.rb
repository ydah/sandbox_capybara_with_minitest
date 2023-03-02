# frozen_string_literal: true

require "capybara"
require "sinatra/base"
require "minitest/autorun"
require "minitest/unit"
require "capybara/dsl"
require "capybara/minitest"

class Sandbox < Sinatra::Base
  get("/") { "<h1>It works!</h1>" }
end

Capybara.app = Sandbox
Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new(app, respect_data_method: true)
end
Capybara.current_driver = :rack_test

class SandboxTest < Minitest::Test
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  def teardown
    Capybara.reset_sessions!
  end

  def test_example
    visit("/")
    assert_text(/It works!/)
  end
end
