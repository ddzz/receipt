describe "ReceiptItem" do
  let(:quantity) { "3" }
  let(:description) { "box of imported chocolates" }
  let(:price) { "11.25" }

  subject { ReceiptItem.new(quantity, description, price) }

  describe "::new" do
    context "with valid input" do
      it "works" do
        receipt = subject
        expect(receipt.quantity).to eq(quantity.to_f)
        expect(receipt.description).to eq(description)
        expect(receipt.price).to eq(price.to_f)
      end
    end
  end

  describe "#imported_item?" do
    context "for imported items" do
      let(:description) { "box of imported chocolates" }
      it "returns true" do
        expect(subject.imported_item?).to be_truthy
      end
    end

    context "for regular items" do
      let(:description) { "music CD" }
      it "returns false" do
        expect(subject.imported_item?).to be_falsey
      end
    end
  end

  describe "#tax_exempt?" do
    context "for exempt items" do
      let (:description) { "headache pills" }
      it "returns true" do
        expect(subject.tax_exempt?).to be_truthy
      end
    end

    context "for non-exempt items" do
      let(:description) { "music CD" }
      it "returns false" do
        expect(subject.tax_exempt?).to be_falsey
      end
    end
  end

  describe "#tax" do
    context "for non-imported items" do
      let(:description) { "headache pills" }
      let(:exempt_tax_amount) { 0.0 }
      it "returns the correct tax amount for one item" do
        expect(subject.tax).to eq(exempt_tax_amount)
      end
    end

    context "for imported items" do
      let(:description) { "imported headache pills" }
      let(:pill_tax_amount) { 0.60 }
      it "returns the correct tax amount for one item" do
        expect(subject.tax).to eq(pill_tax_amount)
      end
    end
  end

  describe "#total_tax" do
    let(:description) { "box of imported chocolates" }
    let(:imported_chocolates_tax) { 1.8 }
    it "returns the total tax for the given quantity" do
      expect(subject.total_tax).to eq(imported_chocolates_tax)
    end
  end

  describe "#total_without_tax" do
    let(:description) { "box of imported chocolates" }
    let(:quantity) { "3" }
    let(:price) { "11.25" }
    let(:chocolates_total_without_tax) { 33.75 }
    it "returns the total without tax" do
      expect(subject.total_without_tax).to eq(33.75)
    end
  end

  describe "#total_price" do
    let(:description) { "box of imported chocolates" }
    let(:quantity) { "3" }
    let(:price) { "11.25" }
    let(:imported_chocolates_total_price) { 35.55 }
    it "returns the total price including tax" do
      expect(subject.total_price).to eq(imported_chocolates_total_price)
    end
  end

  describe "#to_s" do
    let(:description) { "box of imported chocolates" }
    let(:quantity) { "3" }
    let(:price) { "11.25" }
    let(:total_price_with_tax) { 35.55 }
    let(:full_string) { "3 imported box of chocolates: 35.55" }
    it "returns a correctly-formatted string" do
      expect(subject.to_s).to eq(full_string)
    end
  end
end
