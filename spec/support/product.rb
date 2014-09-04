require "#{File.dirname(__FILE__)}/user.rb"

module ProductSupport
  include UserSupport

  def create_product variant = nil
    user = create_user variant

    @product = Product.create! name: "ProductChase#{variant}", \
      link: "http://github.com/hf/productchase#{variant}",
      description: 'Recursion. Funny.',
      user: user
  end
end
