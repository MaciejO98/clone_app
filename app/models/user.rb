class User < ApplicationRecord
  validates :First_name, :Last_name, presence: true, length: {minimum:3 , maximum:50}
  validates :Year_of_birth, presence: true, numericality: { only_integer: true } ##Wypadałoby dać walidacje o datach z przyszłości
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 105}, format: {with: VALID_EMAIL_REGEX}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
end
