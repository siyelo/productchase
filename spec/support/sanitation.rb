module SanitationSupport
  def sanitize_before_validation options
    c = described_class.new options[:dirty]
    c.valid?

    options[:clean].each do |attribute, value|
      expect(c.send(attribute)).to eq value
    end
  end
end
