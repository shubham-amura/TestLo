class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable

  validates :username, uniqueness: true

  validates :phone_no , uniqueness: true, format: { with: /[0-9]/,message: "Must contain only numbers"},
  				     length: { minimum: 10 ,message: "Must be 10 digits"}

end
