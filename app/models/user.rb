require 'bcrypt'

class User < ActiveRecord::Base
  # Remember to create a migration!
      # ej. User.authenticate('fernando@codea.mx', 'qwerty')

  include BCrypt

  has_many :urls

  validates :usuario , presence: true , confirmation: true
  validates :mail , presence: true , confirmation: true
  validates :password , presence: true , confirmation: true
  validates :usuario, uniqueness: true
  validates :mail, uniqueness: true

  # def self.authenticate(email, password)
  #   # si el email y el password corresponden a un usuario valido, regresa el usuario
  #   # de otra manera regresa nil
  #   if User.find_by(mail: email)  
  #     user_find = User.find_by(mail: email)
  #     if email == user_find.mail && password == user_find.password
  #       user_find
  #     else
  #       nil
  #     end
  #   else
  #     nil
  #   end
  # end
  
  def password
    @password ||= Password.new(password_digest)
  end

  def password=(user_password)
    @password = Password.create(user_password)
    self.password_digest = @password
  end

  def self.authenticate(email, user_password)
    user = User.find_by(mail: email)
    if user && (user.password == user_password)
      return user
    else
      nil
    end  
  end  

end
