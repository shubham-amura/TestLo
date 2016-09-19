class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
<<<<<<< HEAD
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, uniqueness: true
  validates :phone_no , uniqueness: true, format: { with: /[0-9]/,message: "Must contain only numbers"},
  				     length: { minimum: 10 ,message: "Must be 10 digits"}
=======
         :recoverable, :rememberable, :trackable, :validatable,:confirmable
>>>>>>> b206283cecaee9813a0b9c4b73e11c33902afe40
end
