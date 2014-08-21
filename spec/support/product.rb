require "#{File.dirname(__FILE__)}/user.rb"

module ProductSupport
  include UserSupport

  def create_product
    create_user

    @product = Product.create! name: 'ProductChase', \
      link: 'http://github.com/hf/productchase',
      description: 'Recursion. Funny.',
      user: @user
  end
end
