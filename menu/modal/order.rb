require_relative('product')

class Order
  attr_reader :items

  def initialize(items)
    @timestamp = Time.now
    @user = []
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