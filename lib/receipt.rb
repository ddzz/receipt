require "pry"
require_relative "receipt_item"

class Receipt
  attr_reader :items
  # regex that splits input lines into three clean array elements
  INPUT_REGEX = /^([0-9]+) ([\w ]+) at ([0-9.]+)$/

  def initialize(filename)
    @items = []

    raw_input = File.open(filename).read
    raw_input.each_line do |line|
      @items << create_receipt_item(line)
    end
  end

  def generate_receipt
    receipt = []
    total = 0.00
    total_tax = 0.00

    @items.each do |item|
      total_tax += item.total_tax
      total += item.total_price
      receipt <<  "#{item.to_s}"
    end

    receipt << "Sales Taxes: #{'%.2f' % total_tax}"
    receipt << "Total: #{'%.2f' % total}"
    receipt
  end

  private

  def create_receipt_item(input_string)
    if input_string.match?(INPUT_REGEX)
      regex_match = input_string.match(INPUT_REGEX)
      ReceiptItem.new(regex_match[1], regex_match[2], regex_match[3])
    else
      raise ArgumentError, "Invalid input file"
    end
  end
end

