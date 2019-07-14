class Member < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :rate, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :discord_id, numericality: true
  has_one :user, dependent: :destroy

  enum position: { 一般: 0, 新規権限: 1, 新規・編集権限: 2, 管理者: 3 }

  scope :autocomplete, ->(term) { where("name LIKE ?", "#{term}%").order(:name) }
end
