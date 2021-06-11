class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :goals
  has_many :subgoals

  # create,update時のみバリテーションを走らせる
  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  # create時のみ走らせる
  validates :password, presence: true, on: :create
  validates :email, uniqueness: true, presence: true
end
