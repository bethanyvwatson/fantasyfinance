class Profile < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :transactions


  def authenticatable_salt
    "#{super}#{session_token}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def invalidate_session!
    self.session_token = SecureRandom.hex
  end
end
