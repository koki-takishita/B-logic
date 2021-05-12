require 'rails_helper'

RSpec.describe User, type: :model do

  it 'メールアドレス、パスワードがあれば有効な状態であること' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'メールアドレスがなければ無効な状態であること' do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include('を入力してください')
  end

  it 'パスワードがなければ無効な状態であること' do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include('を入力してください')
    expect(user.errors[:password]).to include('は6文字以上で入力してください')
  end

  it '確認用パスワードがなければ無効な状態であること' do
    user = build(:user, password_confirmation: nil)
    user.valid?
    expect(user.errors[:password_confirmation]).to include('を入力してください')
  end

  it 'パスワードと確認用パスワードが異なる場合無効な状態であること' do
    user = build(:user, password: '1_password', password_confirmation: '2_password')
    user.valid?
    expect(user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
  end

  it 'パスワードが6文字未満の場合無効な状態であること' do
    user = build(:user, password: 'test', password_confirmation: 'test')
    user.valid?
    expect(user.errors[:password]).to include('は6文字以上で入力してください')
  end

  it '重複したメールアドレスなら無効な状態であること' do
    user_1 = create(:user, email: 'test@exsample.com')
    user_2 = build(:user,  email: 'test@exsample.com')
    user_2.valid?
    expect(user_2.errors[:email]).to include("はすでに存在します")
  end

end
