class Goal < ApplicationRecord
  # インスタンスメソッド
  include Status
  # バリテーション
  include Validators
  # enum
  include Enum_status
  # 属性 selectbox_parameter
  include Attr_accssor
  belongs_to :user
  has_many :subgoals, dependent: :destroy
  validates :what_to_do, presence: true

end
