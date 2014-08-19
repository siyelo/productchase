module ProductsHelper
  def render_errors name, product
    render partial: 'error', locals: { errors: product.errors.get(name) }
  end
end
