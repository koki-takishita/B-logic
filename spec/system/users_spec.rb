require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'ユーザー新規作成機能' do
    let(:user) { build(:user) }
    let(:not_match_password_user) { build(:user, :not_match_password) }
    let(:shortage_password_user) { build(:user, :shortage_password) }

    before do
      visit new_user_path
    end

    context 'すべての属性が有効な状態' do
      it 'ユーザー新規作成に成功する' do
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        fill_in 'パスワード(確認)', with: user.password_confirmation
        click_button '登録する'
        expect(page).to have_content 'User was successfully created.'
      end
    end

    context '一部属性を入力していない状態' do
      context 'emailを入力していない' do
        it 'ユーザー新規作成に失敗する' do
          fill_in 'メールアドレス', with: nil
          fill_in 'パスワード', with: user.password
          fill_in 'パスワード(確認)', with: user.password_confirmation
          click_button '登録する'
          expect(page).to have_content 'メールアドレスを入力してください'
        end
      end
      context 'passwordを入力していない' do
        it 'ユーザー新規作成に失敗する' do
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: nil
          fill_in 'パスワード(確認)', with: user.password_confirmation
          click_button '登録する'
          expect(page).to have_content 'パスワードを入力してください'
        end
      end
      context '確認用パスワードを入力していない' do
        it 'ユーザー新規作成に失敗する' do
          fill_in 'メールアドレス', with: user.password
          fill_in 'パスワード', with: user.password
          fill_in 'パスワード(確認)', with: nil
          click_button '登録する'
          expect(page).to have_content 'パスワード(確認)を入力してください'
        end
      end
    end

    context 'セキュリティー関連' do
      context 'パスワードが６文字未満の場合' do
        it 'ユーザー新規作成に失敗する' do
          fill_in 'メールアドレス', with: shortage_password_user.email
          fill_in 'パスワード', with: shortage_password_user.password
          fill_in 'パスワード(確認)', with: shortage_password_user.password_confirmation
          click_button '登録する'
          expect(page).to have_content 'パスワードは6文字以上で入力してください'
        end
      end
      context 'パスワードと確認用パスワードが一致しない場合' do
        it 'ユーザー新規作成に失敗する' do
          fill_in 'メールアドレス', with: not_match_password_user.email
          fill_in 'パスワード', with: not_match_password_user.password
          fill_in 'パスワード(確認)', with: not_match_password_user.password_confirmation
          click_button '登録する'
          expect(page).to have_content 'パスワード(確認)とパスワードの入力が一致しません'
        end
      end
      context '重複したメールアドレスの場合' do
        it 'ユーザー新規作成に失敗する' do
          first_user = create(:user, email:  'test@example.com')
          second_user = build(:user, email: 'test@example.com')
          fill_in 'メールアドレス', with: second_user.email
          fill_in 'パスワード', with: second_user.password
          fill_in 'パスワード(確認)', with: second_user.password_confirmation
          click_button '登録する'
          expect(page).to have_content 'メールアドレスはすでに存在します'
        end
      end
    end
  end

  describe 'ログイン機能' do
    let(:user) { create(:user) }

    before do
      visit login_path
    end

    context '登録済みのユーザー' do
      it 'ログインできる' do
        fill_in 'メールアドレス', with: user.email
        # createだと、passwordが「""」になるため
        # 直接'password'を入力している
        fill_in 'パスワード', with: 'password'
        click_button 'Login'
        expect(page).to have_content 'Login successful'
        expect(current_path).to eq users_path
      end
      context '一部情報を入力していない' do
        context 'メールアドレスを入力していない' do
          it 'ログインできない' do
            fill_in 'メールアドレス', with: ''
            fill_in 'パスワード', with: 'password'
            click_button 'Login'
            expect(page).to have_content 'Login failed'
          end
        end
        context 'passwordを入力していない' do
          it 'ログインできない' do
            fill_in 'メールアドレス', with: user.email
            fill_in 'パスワード', with: ''
            click_button 'Login'
            expect(page).to have_content 'Login failed'
          end
        end
      end
      context '属性が間違っている' do
        context 'メールアドレスが間違っている' do
          it 'ログインできない' do
            fill_in 'メールアドレス', with: 'test@example.com'
            fill_in 'パスワード', with: 'password'
            click_button 'Login'
            expect(page).to have_content 'Login failed'
          end
        end
        context 'passwordが間違っている' do
          it 'ログインできない' do
            fill_in 'メールアドレス', with: user.email
            fill_in 'パスワード', with: 'foobar'
            click_button 'Login'
            expect(page).to have_content 'Login failed'
          end
        end
      end
    end
  end

  describe 'ログアウト機能' do
    let(:user) { create(:user) }
    context 'ログイン済み' do

      before do
        login_as user
      end

      context 'indexページ' do
        it 'ログアウトできる' do
          visit users_path
          click_link 'Logout'
          expect(page).to have_content 'Logged out!'
          expect(current_path).to eq users_path
        end
      end
      context 'editページ' do
        it 'ログアウトできる' do
          visit edit_user_path(user)
          click_link 'Logout'
          expect(page).to have_content 'Logged out!'
          expect(current_path).to eq users_path
        end
      end
      context 'showページ' do
        it 'ログアウトできる' do
          visit user_path(user)
          click_link 'Logout'
          expect(page).to have_content 'Logged out!'
          expect(current_path).to eq users_path
        end
      end
    end
  end

  describe 'ユーザー編集機能' do
    let(:user) { create(:user) }

    before do
      login_as user
    end

    context '属性一部変更' do

      before do
        visit edit_user_path(user)
      end

      context 'メールアドレス変更' do
        it '更新成功' do
          fill_in 'メールアドレス', with: 'foobar@example.com'
          click_button '更新する'
          expect(page).to have_content 'User was successfully updated.'
          expect(current_path).to eq user_path(user)
        end
      end
      context 'password変更' do
        it '更新成功' do
          fill_in 'パスワード', with: 'foobar'
          fill_in 'パスワード(確認)', with: 'foobar'
          click_button '更新する'
          expect(page).to have_content 'User was successfully updated.'
          expect(current_path).to eq user_path(user)
        end
      end
    end
  end

  describe 'ユーザー削除機能' do
    context 'adminユーザー' do
      it '削除できる' do
        skip '未実装'
      end
    end
    context '一般ユーザー' do
      it '削除できない' do
        skip '未実装'
      end
    end
  end
end
