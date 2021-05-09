require 'rails_helper'

RSpec.describe User, type: :model do

  it 'メールアドレス、パスワードがあれば有効な状態であること' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'メールアドレスがなければ無効な状態であること' do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'パスワードがなければ無効な状態であること' do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
    expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
  end

  it '確認用パスワードがなければ無効な状態であること' do
    user = build(:user, password_confirmation: nil)
    user.valid?
    expect(user.errors[:password_confirmation]).to include("can't be blank")
  end

  it 'パスワードと確認用パスワードが異なる場合無効な状態であること' do
    user = build(:user, password: '1_password', password_confirmation: '2_password')
    user.valid?
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end

  it 'パスワードが6文字未満の場合無効な状態であること' do
    user = build(:user, password: 'test', password_confirmation: 'test')
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
  end

  it '重複したメールアドレスなら無効な状態であること' do
    user_1 = create(:user, email: 'test@exsample.com')
    user_2 = build(:user,  email: 'test@exsample.com')
    user_2.valid?
    expect(user_2.errors[:email]).to include("has already been taken")
  end

end
