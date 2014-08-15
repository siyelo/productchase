module ValidationSupport
  def validate_without_errors attributes
    c = described_class.new attributes
    c.valid?

    attributes.keys.each { |k| expect(c.errors[k]).to eq [] }
  end

  def validate_with_errors attributes
    c = described_class.new attributes
    c.valid?

    attributes.keys.each { |k| expect(c.errors[k]).not_to eq [] }
  end
end
