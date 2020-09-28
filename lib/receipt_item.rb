require "pry"

class ReceiptItem
  IMPORTED_ITEM = "imported".freeze
  EXEMPT_ITEMS = ["book", "chocolate", "pill"].freeze
  IMPORT_DUTY = 0.05
  SALES_TAX = 0.10

  attr_reader :quantity, :description, :price

  def initialize(quantity, description, price)
    @quantity = quantity.to_f
    @description = description
    @price = price.to_f
  end

  def total_tax
    (@quantity * tax).round(2)
  end

  def total_without_tax
    (@quantity * @price).round(2)
  end

  def total_price
    (@quantity * @price + total_tax).round(2)
  end

  def to_s
    "#{@quantity.floor} #{imported_description}: #{'%.2f' % total_price}"
  end

  def imported_item?
    @description.include?(IMPORTED_ITEM) ? true : false
  end

  def tax_exempt?
    EXEMPT_ITEMS.any? { |exempt| @description.include?(exempt) } ? true : false
  end

  def tax
    tax_rate = 0.00

    if imported_item?
      tax_rate  += IMPORT_DUTY
    end

    if !tax_exempt?
      tax_rate += SALES_TAX
    end

    rounded_tax(tax_rate * @price).to_f
  end

  private

  def imported_description
    if imported_item? and @description.index(IMPORTED_ITEM) > 0
      @description = @description.slice!(IMPORTED_ITEM + " ") + @description
    else
      @description
    end
  end

  # round up by 0.05
  def rounded_tax(raw_tax)
    (raw_tax * 20).ceil.round / 20.0
  end
end
