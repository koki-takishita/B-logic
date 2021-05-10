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
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Password confirmation', with: user.password_confirmation
        click_button 'Create User'
        expect(page).to have_content 'User was successfully created.'
      end
    end

    context '一部属性を入力していない状態' do
      context 'emailを入力していない' do
        it 'ユーザー新規作成に失敗する' do
          fill_in 'Email', with: nil
          fill_in 'Password', with: user.password
          fill_in 'Password confirmation', with: user.password_confirmation
          click_button 'Create User'
          expect(page).to have_content "Email can't be blank"
        end
      end
      context 'passwordを入力していない' do
        it 'ユーザー新規作成に失敗する' do
          fill_in 'Email', with: user.email
          fill_in 'Password', with: nil
          fill_in 'Password confirmation', with: user.password_confirmation
          click_button 'Create User'
          expect(page).to have_content "Password can't be blank"
        end
      end
      context '確認用パスワードを入力していない' do
        it 'ユーザー新規作成に失敗する' do
          fill_in 'Email', with: user.password
          fill_in 'Password', with: user.password
          fill_in 'Password confirmation', with: nil
          click_button 'Create User'
          expect(page).to have_content "Password confirmation can't be blank"
        end
      end
    end

    context 'セキュリティー関連' do
      context 'パスワードが６文字未満の場合' do
        it 'ユーザー新規作成に失敗する' do
          fill_in 'Email', with: shortage_password_user.email
          fill_in 'Password', with: shortage_password_user.password
          fill_in 'Password confirmation', with: shortage_password_user.password_confirmation
          click_button 'Create User'
          expect(page).to have_content 'Password is too short (minimum is 6 characters)'
        end
      end
      context 'パスワードと確認用パスワードが一致しない場合' do
        it 'ユーザー新規作成に失敗する' do
          fill_in 'Email', with: not_match_password_user.email
          fill_in 'Password', with: not_match_password_user.password
          fill_in 'Password confirmation', with: not_match_password_user.password_confirmation
          click_button 'Create User'
          expect(page).to have_content "Password confirmation doesn't match Password"
        end
      end
      context '重複したメールアドレスの場合' do
        it 'ユーザー新規作成に失敗する' do
          first_user = create(:user, email:  'test@example.com')
          second_user = build(:user, email: 'test@example.com')
          fill_in 'Email', with: second_user.email
          fill_in 'Password', with: second_user.password
          fill_in 'Password confirmation', with: second_user.password_confirmation
          click_button 'Create User'
          expect(page).to have_content 'Email has already been taken'
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
        fill_in 'Email', with: user.email
        # createだと、passwordが「""」になるため
        # 直接'password'を入力している
        fill_in 'Password', with: 'password'
        click_button 'Login'
        expect(page).to have_content 'Login successful'
        expect(current_path).to eq users_path
      end
      context '一部情報を入力していない' do
        context 'emailを入力していない' do
          it 'ログインできない' do
            fill_in 'Email', with: ''
            fill_in 'Password', with: 'password'
            click_button 'Login'
            expect(page).to have_content 'Login failed'
          end
        end
        context 'passwordを入力していない' do
          it 'ログインできない' do
            fill_in 'Email', with: user.email
            fill_in 'Password', with: ''
            click_button 'Login'
            expect(page).to have_content 'Login failed'
          end
        end
      end
      context '属性が間違っている' do
        context 'emailが間違っている' do
          it 'ログインできない' do
            fill_in 'Email', with: 'test@example.com'
            fill_in 'Password', with: 'password'
            click_button 'Login'
            expect(page).to have_content 'Login failed'
          end
        end
        context 'passwordが間違っている' do
          it 'ログインできない' do
            fill_in 'Email', with: user.email
            fill_in 'Password', with: 'foobar'
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

      context 'email変更' do
        it '更新成功' do
          fill_in 'Email', with: 'foobar@example.com'
          click_button 'Update User'
          expect(page).to have_content 'User was successfully updated.'
          expect(current_path).to eq user_path(user)
        end
      end
      context 'password変更' do
        it '更新成功' do
          fill_in 'Password', with: 'foobar'
          fill_in 'Password confirmation', with: 'foobar'
          click_button 'Update User'
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
