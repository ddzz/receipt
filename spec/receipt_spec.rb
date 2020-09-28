require "pry"

describe "Receipt" do
  subject { Receipt  }
  let(:receipt_item) { instance_double("ReceiptItem")  }

  describe "::new" do
    context "invalid input file" do
      let(:file_path) { File.dirname(__FILE__) + "/support/bad_input.txt" }
      it "throws an exception" do
        expect(ReceiptItem).to receive(:new).with("2", "book", "12.49").and_return(receipt_item)
        expect(ReceiptItem).not_to receive(:new).with("1", "music CD")
        expect(ReceiptItem).not_to receive(:new).with("chocolate bar", "0.85")
        expect{ subject.new(file_path) }.to raise_error(ArgumentError, "Invalid input file")
      end
    end

    context "first input file" do
      let(:file_path) { File.dirname(__FILE__) + "/support/test_file.txt" }
      it "has correct initial values" do
        expect(ReceiptItem).to receive(:new).with("2", "book", "12.49").and_return(receipt_item)
        expect(ReceiptItem).to receive(:new).with("1", "music CD", "14.99").and_return(receipt_item)
        expect(ReceiptItem).to receive(:new).with("1", "chocolate bar", "0.85").and_return(receipt_item)
        receipt = subject.new(file_path)
        expect(receipt.items.length).to eql(3)
      end
    end

    context "second input file" do
      let(:file_path) { File.dirname(__FILE__) + "/support/test_file2.txt" }
      it "has correct initial values" do
        expect(ReceiptItem).to receive(:new).with("1", "imported box of chocolates", "10.00").and_return(receipt_item)
        expect(ReceiptItem).to receive(:new).with("1", "imported bottle of perfume", "47.50").and_return(receipt_item)
        receipt = subject.new(file_path)
        expect(receipt.items.length).to eql(2)
      end
    end

    context "third input file" do
      let(:file_path) { File.dirname(__FILE__) + "/support/test_file3.txt" }
      it "has correct initial values" do
        expect(ReceiptItem).to receive(:new).with("1", "imported bottle of perfume", "27.99").and_return(receipt_item)
        expect(ReceiptItem).to receive(:new).with("1", "bottle of perfume", "18.99").and_return(receipt_item)
        expect(ReceiptItem).to receive(:new).with("1", "packet of headache pills", "9.75").and_return(receipt_item)
        expect(ReceiptItem).to receive(:new).with("3", "box of imported chocolates", "11.25").and_return(receipt_item)
        receipt = subject.new(file_path)
        expect(receipt.items.length).to eql(4)
      end
    end
  end

  describe "#print_receipt" do
    context "first input file" do
      let(:file_path) { File.dirname(__FILE__) + "/support/test_file.txt" }
      let(:item_1) { "2 book: 24.98" }
      let(:item_2) { "1 music CD: 16.49" }
      let(:item_3) { "1 chocolate bar: 0.85" }
      let(:taxes) { "Sales Taxes: 1.50" }
      let(:total) { "Total: 42.32" }
      it "prints the correct receipt values" do
        receipt = subject.new(file_path)
        expect(receipt.generate_receipt).to contain_exactly(
          item_1, item_2, item_3, taxes, total
        )
      end
    end
 
    context "second input file" do
      let(:file_path) { File.dirname(__FILE__) + "/support/test_file2.txt" }
      let(:item_1) { "1 imported box of chocolates: 10.50" }
      let(:item_2) { "1 imported bottle of perfume: 54.65" }
      let(:taxes) { "Sales Taxes: 7.65" }
      let(:total) { "Total: 65.15" }
      it "prints the correct receipt values" do
        receipt = subject.new(file_path)
        expect(receipt.generate_receipt).to contain_exactly(
          item_1, item_2, taxes, total
        )
      end
    end

    context "third input file" do
      let(:file_path) { File.dirname(__FILE__) + "/support/test_file3.txt" }
      let(:item_1) { "1 imported bottle of perfume: 32.19" }
      let(:item_2) { "1 bottle of perfume: 20.89" }
      let(:item_3) { "1 packet of headache pills: 9.75" }
      let(:item_4) { "3 imported box of chocolates: 35.55" }
      let(:taxes) { "Sales Taxes: 7.90" }
      let(:total) { "Total: 98.38" }
      it "prints the correct receipt values" do
        receipt = subject.new(file_path)
        expect(receipt.generate_receipt).to contain_exactly(
          item_1, item_2, item_3, item_4, taxes, total
        )
      end
    end
  end
end

