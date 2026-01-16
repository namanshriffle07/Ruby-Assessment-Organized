require_relative('../modal/user')

module AuthFeatures
  def signup
    print "Please enter your email: "
    email = gets.chomp
    print "Please enter your password: "
    password = gets.chomp

    valid = validate_email(email) && validate_password(password)
    if valid
      User.add(User.new(email, password,"Normal User"))
      @usr.sign_up(email,password)
    end
    if !validate_email(email)
      puts "Please enter a valid email"
    end
    if !validate_password(password)
      puts "Please enter a valid password"
    end
  end

  def signin
    File.readlines("credential.txt").each do |line|
      username, password = line.strip.split("=")
      User.add(User.new(username, password,"User"))
    end

    print "Email: "
    email = gets.chomp
    print "Password: "
    password = gets.chomp

    user = User.find(email)
    valid = validate_email(email) && validate_password(password)
    
    if valid
      if @usr.login(email,password)
        user_menu(user)
      end
    end
    if !validate_email(email)
      puts "Please enter a valid email address"
    end
    if !validate_password(password)
      puts "Please enter a valid password"
    end
  end

  def create_admin
    print "Please enter your email: "
    email = gets.chomp
    print "Please enter your password: "
    password = gets.chomp

    exist = User.find(email)

    valid = validate_email(email) && validate_password(password)
    
    if valid
      if !exist
        User.add(User.new(email, password,"Admin"))
        @admin_auth.sign_up(email, password)
        puts "Admin created successfully\nEmail : #{email}"
      end
    end
    if exist
      puts "Admin already exists!"
    end
    if !validate_email(email)
      puts "Please enter a valid email address"
    end
    if !validate_password(password)
      puts "Please enter a valid password"
    end
  end

  def admin_login
    print "Email: "
    email = gets.chomp
    print "Password: "
    password = gets.chomp

    File.readlines("admin.txt").each do |line|
      username, password = line.strip.split("=")
      User.add(User.new(username, password,"Admin"))
    end


    if validate_email(email) && validate_password(password)
      if @admin_auth.login(email, password) 
        usr = User.find(email)
        admin_menu(usr)
      end
    end
    if !validate_email(email)
      puts "Please enter a valid email"
    end
    if !validate_password(password)
      puts "Please enter a valid password"
    end
  end
end