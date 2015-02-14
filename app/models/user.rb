class User < ActiveRecord::Base
  has_secure_password

  has_many :subscriptions, dependent: :nullify

  validates :email, presence: true, uniqueness: true,
            email_format: true

  def full_name
    if first_name || last_name
      "#{first_name} #{last_name}"
    else
      email
    end
  end
end
