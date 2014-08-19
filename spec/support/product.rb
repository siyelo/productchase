module ProductSupport
  def create_product
    @product = Product.create! name: 'ProductChase', link: 'http://github.com/hf/productchase', description: 'Recursion. Funny.'
  end
end
