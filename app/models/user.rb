class User < ApplicationRecord
  validates :name,uniqueness: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, uniqueness: true
  belongs_to :member

  def email_required?
   false
  end

  def email_changed?
   false
  end

  def will_save_change_to_email?
    false
  end

end
