require 'rails_helper'

RSpec.describe User, type: :model do

  it 'メールアドレス、パスワードがあれば有効な状態であること'
  it 'メールアドレスがなければ無効な状態であること'
  it 'パスワードがなければ無効な状態であること'
  it '重複したメールアドレスなら無効な状態であること'
end
