require_relative('modal/product')
require_relative('services/auth_service')
require_relative('modules/validator')
require_relative('modules/user_features')
require_relative('modules/admin_features')
require_relative('modules/auth_features')
require('uri')

class Menu
  include Validator
  include UserFeatures
  include AdminFeatures
  include AuthFeatures

  def initialize
    Product.seed
    @usr = AuthService.new("credential.txt")
    @admin_auth = AuthService.new("admin.txt")
    default_admin
  end

  def default_admin
    admin_users = @admin_auth.load_users
    if admin_users.empty?
      puts "No admin found please register one"
      print "Please enter your email: "
      email = gets.chomp
      print "Please enter your password: "
      password = gets.chomp
      valid = validate_email(email) && validate_password(password)
      if valid
        User.add(User.new(email, password,"Admin user"))
        @admin_auth.sign_up(email,password)
      end
      if !validate_email(email)
        puts "Please enter a valid email"
      end
      if !validate_password(password)
        puts "Please enter a valid password"
      end
    end
  end

  def main_menu
    loop do
      puts "\n1. Sign Up\n2. Sign In\n3. Create Admin\n4. Admin Login\n5. Exit"
      case gets.to_i
      when 1
        signup
      when 2
        signin
      when 3
        create_admin
      when 4
        admin_login
      when 5
        break
      else
        puts "Invalid option"
      end
    end
  end
end