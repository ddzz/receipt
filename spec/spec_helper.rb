require "rspec"
require_relative "../lib/receipt"
require_relative "../lib/receipt_item"

RSpec.configure do |config|
  config.warnings = true
  config.default_formatter = "doc"
  config.order = :random
  Kernel.srand config.seed
end
