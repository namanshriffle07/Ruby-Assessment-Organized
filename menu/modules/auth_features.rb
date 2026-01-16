require_relative('../modal/user')
require_relative('../modal/admin')

module AuthFeatures
  def signup
    print "Please enter your email: "
    email = gets.chomp
    print "Please enter your password: "
    password = gets.chomp

    valid = validate_email(email) && validate_password(password)
    if valid
      User.add(User.new(email, password))
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
      
        User.add(Admin.new(email, password))
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

    if validate_email(email) && validate_password(password)
      if @admin_auth.login(email, password)
        admin_menu
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