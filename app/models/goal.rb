class Goal < ApplicationRecord
  belongs_to :user

  # カスタムバリテーション(input_attributes_nil?)実装のために作成
  attr_accessor :input_all_attributes

  enum status: { inactive: 0, active: 1 }
  validates :embodiment, presence: true, if: :goal_active?
  validates :unit, presence: true, if: :goal_active?
  validates :what_to_do, presence: true, if: :goal_active?
  validates :quantification, presence: true, if: :goal_active?
  validate  :input_attributes_nil?

  def goal_active?
    status == 'active'
  end

  # 入力項目がすべて空の状態で目標を作成しようとした場合、エラー、ユーザに入力を促す
  def input_attributes_nil?
    if embodiment.nil? && unit.nil? && what_to_do.nil? && quantification.nil?
      errors.add(:input_all_attributes, :input_attributes_blank)
    end
  end
end
