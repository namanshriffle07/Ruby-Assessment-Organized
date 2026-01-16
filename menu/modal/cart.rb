require_relative('order')
require_relative('product')

class Cart
  def initialize
    @items = Hash.new(0)
  end

  def add_product(product, qty)
    if product.quantity < qty
      puts "Not enough stock"
    else 
      @items[product] +=  qty
    end
  end

  def empty?
    @items.empty?
  end

  def total
    @items.sum { |product, qty| product.price * qty }
  end

  def checkout
    @totalamt = 0
    @items.each do |product, qty|
      amt = product.price * qty
      @totalamt += amt
      product.quantity -= qty
    end
    order = Order.new(@items.clone)
    @items.clear
    puts "Total amount : #{@totalamt}"
    order
  end

  def view
    if @items.size == 0
      puts "Cart is empty"
    end
    @items.each do |product, qty|
      puts "Product: #{product.name}  Quantity: #{qty}"
    end
  end
end