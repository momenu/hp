class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def general?
    member.position == '一般'
  end

  def authority?
    member.position == '新規権限' || member.position == '新規・編集権限' || member.position == '管理者'
  end

  def maneger?
    member.position == '新規・編集権限' || member.position == '管理者'
  end

  def admin?
    member.position == '管理者'
  end
end
