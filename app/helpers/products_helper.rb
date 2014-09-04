module ProductsHelper
  def render_errors name, product
    render partial: 'error', locals: { errors: product.errors.get(name) }
  end

  def day_name day
    if day.today?
      "Today"
    elsif (day + 1.day).today?
      "Yesterday"
    else
      day.strftime '%A'
    end
  end
end
