require_relative('product')

class Order
  def initialize(items)
    @items = items
    @timestamp = Time.now
    @user = []
  end

  def items 
    @items
  end

  def timestamp
    @timestamp
  end

  def details
    puts "Order placed at #{@timestamp}"
    @items.each do |product, qty|
      puts "Product:#{product.name}  Quantity: #{qty}"
      puts "Total amount : #{product.price * qty}"
    end
  end
end