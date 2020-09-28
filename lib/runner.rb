require_relative 'receipt'

if ARGV[0] == nil
  puts "Please specify an input file."
  puts
  puts "  Usage:"
  puts "    ruby lib/receipt.rb /path/to/input/txt/file"
  puts
  exit
end

receipt = Receipt.new(ARGV[0])
puts receipt.generate_receipt
