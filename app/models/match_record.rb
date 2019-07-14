class MatchRecord < ApplicationRecord
  has_many :member
  validates :player1 , presence: true
  validates :player2 , presence: true
  validates :player3 , presence: true
  validates :player4 , presence: true
  validates :player5 , presence: true
  validates :player6 , presence: true
  validates :player7 , presence: true
  validates :player8 , presence: true
  validate :different_player
  validate :check_existence


  def different_player
    duplicate = [player1, player2, player3, player4, player5, player6, player7, player8].reject(&:blank?).group_by{ |e| e }.select{ |k,v| v.size > 1 }.map(&:first)
    errors[:base] << "#{duplicate.join(',')}が重複しています。"  if duplicate.present?
  end

  def check_existence
    [player1, player2, player3, player4, player5, player6, player7, player8].reject(&:blank?).each do |player|
      errors[:base] << "#{player}は存在しません。" if Member.where(name: player).blank?
    end
  end
end
