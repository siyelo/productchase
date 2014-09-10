class ProductGrouping
  attr_reader :groups
  attr_reader :products

  def initialize products
    @products = products
    @groups = @products.group_by { |p| p.created_at.midnight }
               .entries.sort_by { |e| e.first }.reverse
               .map do |e|
                  { :day => e.first,
                    :entries => e.last.sort_by { |p| p.votes.count }.reverse }
                end
  end

  def each
    @groups.each do |group|
      yield group[:day], group[:entries]
    end
  end
end
