require 'rails_helper'

RSpec.describe User, type: :model do

  it 'メールアドレス、パスワードがあれば有効な状態であること' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'メールアドレスがなければ無効な状態であること' do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include(I18n.t('errors.messages.blank'))
  end

  it 'パスワードがなければ無効な状態であること' do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include(I18n.t('errors.messages.blank'))
    expect(user.errors[:password]).to include(I18n.t('errors.messages.too_short', count: 6))
  end

  it '確認用パスワードがなければ無効な状態であること' do
    user = build(:user, password_confirmation: nil)
    user.valid?
    expect(user.errors[:password_confirmation]).to include(I18n.t('errors.messages.blank'))
  end

  it 'パスワードと確認用パスワードが異なる場合無効な状態であること' do
    user = build(:user, password: '1_password', password_confirmation: '2_password')
    user.valid?
    expect(user.errors[:password_confirmation]).to include(I18n.t('errors.messages.confirmation', attribute: I18n.t('activerecord.attributes.user.password')))
  end

  it 'パスワードが6文字未満の場合無効な状態であること' do
    user = build(:user, password: 'test', password_confirmation: 'test')
    user.valid?
    expect(user.errors[:password]).to include(I18n.t('errors.messages.too_short', count: 6))
  end

  it '重複したメールアドレスなら無効な状態であること' do
    user_1 = create(:user, email: 'test@exsample.com')
    user_2 = build(:user,  email: 'test@exsample.com')
    user_2.valid?
    expect(user_2.errors[:email]).to include(I18n.t('errors.messages.taken'))
  end
end
