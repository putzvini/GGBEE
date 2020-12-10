class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create :send_welcome_email

  private

  def send_welcome_email

    UserMailer.with(user: self).welcome.deliver_now
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
