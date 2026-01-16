require_relative('../modal/cart')
require_relative('../modal/user')

module UserFeatures
  def user_menu(user)
    cart = Cart.new
    loop do
      puts "\n1. View Products\n2. Add to Cart\n3. View Cart\n4. Checkout\n5. View Orders\n6. Sign Out"
      case gets.to_i
      when 1
        view_products
      when 2
        print "Product ID: "
        product_id = gets
        print "Quantity: "
        qty = gets
        if product_id =~ /^\d+$/ && qty =~ /^\d+$/
          product_id = product_id.to_i
          qty = qty.to_i
          if qty <= 0
            puts "Please enter a valid product quantity"
          else 
            product = Product.find(product_id)
            if product == nil
              puts "Product not found"
            else 
              cart.add_product(product, qty)
              puts "Product successfully added to cart"
            end
          end
        else
          puts "Enter product id and quantity in valid format"
        end
      when 3
        cart.view
      when 4
        if cart.empty?
          puts "Cart is empty"
        else
          @order = cart&.checkout
          puts "Order placed successfully"
        end
      when 5
        puts "Order details"
        @order.details
      when 6
        break
      else
        puts "Invalid option"
      end
    end
  end

  def view_products
    Product.all.each do |p|
      puts "Product ID:#{p.id} Name:#{p.name} Price:#{p.price} (#{p.quantity} available)"
    end
  end
end