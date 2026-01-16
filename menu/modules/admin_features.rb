require_relative('../modal/product')

module AdminFeatures
  def admin_menu(usr)
    loop do
      puts "User type : #{usr.usertype}"
      puts "\n1. Add Product\n2. Update Product\n3. Delete Product\n4. View Products\n5. Sign Out"
      case gets.to_i
      when 1
        add_product
      when 2
        update_product
      when 3
        delete_product
      when 4
        view_products
      when 5
        puts "Exiting..."
        break
      else
        puts "Invalid option"
      end
    end
  end

  def add_product
    print "Name: "
    name = gets.chomp
    print "Price: "
    price = gets
    print "Quantity: "
    qty = gets
    
    if price =~ /^\d+$/ && qty =~ /^\d+$/
      id = Product.all.size + 1
      price = price.to_i
      qty = qty.to_i
      if !name.match?(/^\d+$/)
        if price<=0 || qty<=0
          if price <= 0
            puts "Please enter a valid price"
          end
          if qty <=0
            puts "Please enter a valid product quantity"
          end
        else
          Product.add(Product.new(id, name, price, qty))
          puts "Product added successfully"
        end
      else
        puts "Product name can't be number : "
      end
    else 
      puts "Invalid product details"
    end
  end

  def update_product
    print "Product ID: "
    product_id = gets
    print "New Price: "
    product_price = gets
    print "New Quantity: "
    product_quantity = gets
    if product_id =~ /^\d+$/ && product_price =~ /^\d+$/ && product_quantity =~ /^\d+$/
      product_id = product_id.to_i
      product_price = product_price.to_f
      product_quantity = product_quantity.to_i

      if product_price <= 0 || product_id <= 0    
        if product_price <= 0
          puts "Please enter a valid product price"
        end
        if product_id <= 0
          puts "Please enter a valid product id"
        end
      else 
        product = Product.find(product_id)
        product.price = product_price
        product.quantity = product_quantity
        puts "Product successfully updated"
      end 
    else
      puts "Invalid product details"
    end
  end

  def delete_product
    print "Product ID: "
    product_id = gets
    if product_id =~ /^\d+$/
      product_id = product_id.to_i
      product = Product.find(product_id)
      if product == nil 
        puts "Product not found"
      else
        Product.all.delete(product)
        puts "Product deleted successfully"
      end
    else
      puts "Enter a valid product id"
    end
  end
end