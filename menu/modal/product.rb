class Product
  @@products = []

  def self.all
    @@products
  end

  def self.add(product)
    @@products << product
  end

  def self.find(id)
    @@products.find { |p| p.id == id }
  end

  def self.seed
    product_details = {"id"=>1,"name"=>"leptop","price"=>1000,"quantity"=>5}
    
    count = 0
    5.times do
      @@products << Product.new(product_details["id"]+count,"#{product_details["name"]}#{count}",product_details["price"]+count,product_details["quantity"]+count)
      count += 1      
    end   
  end

  def id
    @id 
  end

  def name
    @name
  end

  def price
    @price
  end

  def quantity
    @quantity
  end

  def review
    @review
  end

  def id=(id)
    @id = id
  end

  def name=(name)
    @name = name
  end

  def price=(price)
    @price = price
  end

  def quantity=(quantity)
    @quantity = quantity
  end

  def initialize(id, name, price, quantity)
    
    if price < 0
      puts "invalid prise"
    end

    if quantity < 0
      puts "Invalid quantiti"
    end
    @id = id
    @name = name
    @price = price
    @quantity = quantity
    @review = "All good"
  end

  def available?
    @quantity > 0
  end
end