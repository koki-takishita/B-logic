require 'rails_helper'

RSpec.describe "Users", type: :system, js: true do
  describe 'ユーザー新規作成機能' do
    let(:user) { build(:user) }
    let(:not_match_password_user) { build(:user, :not_match_password) }
    let(:shortage_password_user) { build(:user, :shortage_password) }

    before do
      visit root_path
      click_button '新規登録'
    end

    context 'すべての属性が有効な状態' do
      it 'ユーザー新規作成に成功する' do
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        fill_in 'user_password_confirmation', with: user.password_confirmation
        click_button I18n.t 'helpers.submit.create' 
        expect(page).to have_content I18n.t 'users.create.success'
      end
    end

    context '一部属性を入力していない状態' do
      context 'emailを入力していない' do
        it 'ユーザー新規作成に失敗する' do
          fill_in 'user_email', with: nil
          fill_in 'user_password', with: user.password
          fill_in 'user_password_confirmation', with: user.password_confirmation
          click_button I18n.t 'helpers.submit.create' 
          expect(page).to have_content  I18n.t 'users.create.danger'
          expect(page).to have_content 'メールアドレスを入力してください'
        end
      end
      context 'passwordを入力していない' do
        it 'ユーザー新規作成に失敗する' do
          fill_in 'user_email', with: user.email
          fill_in 'user_password', with: nil
          fill_in 'user_password_confirmation', with: user.password_confirmation
          click_button I18n.t 'helpers.submit.create' 
          expect(page).to have_content  I18n.t 'users.create.danger'
          expect(page).to have_content 'パスワードを入力してください'
        end
      end
      context '確認用パスワードを入力していない' do
        it 'ユーザー新規作成に失敗する' do
          fill_in 'user_email', with: user.email
          fill_in 'user_password', with: user.password
          fill_in 'user_password_confirmation', with: nil
          click_button I18n.t 'helpers.submit.create' 
          expect(page).to have_content  I18n.t 'users.create.danger'
          expect(page).to have_content 'パスワード(確認)を入力してください'
        end
      end
    end

    context 'セキュリティー関連' do
      context 'パスワードが６文字未満の場合' do
        it 'ユーザー新規作成に失敗する' do
          fill_in 'user_email', with: shortage_password_user.email
          fill_in 'user_password', with: shortage_password_user.password
          fill_in 'user_password_confirmation', with: shortage_password_user.password_confirmation
          click_button I18n.t 'helpers.submit.create' 
          expect(page).to have_content  I18n.t 'users.create.danger'
          expect(page).to have_content 'パスワードは6文字以上で入力してください'
        end
      end
      context 'パスワードと確認用パスワードが一致しない場合' do
        it 'ユーザー新規作成に失敗する' do
          fill_in 'user_email', with: not_match_password_user.email
          fill_in 'user_password', with: not_match_password_user.password
          fill_in 'user_password_confirmation', with: not_match_password_user.password_confirmation
          click_button I18n.t 'helpers.submit.create' 
          expect(page).to have_content  I18n.t 'users.create.danger'
          expect(page).to have_content 'パスワード(確認)とパスワードの入力が一致しません'
        end
      end
      context '重複したメールアドレスの場合' do
        it 'ユーザー新規作成に失敗する' do
          first_user = create(:user, email:  'test@example.com')
          second_user = build(:user, email: 'test@example.com')
          fill_in 'user_email', with: second_user.email
          fill_in 'user_password', with: second_user.password
          fill_in 'user_password_confirmation', with: second_user.password_confirmation
          click_button I18n.t 'helpers.submit.create' 
          expect(page).to have_content  I18n.t 'users.create.danger'
          expect(page).to have_content 'メールアドレスはすでに存在します'
        end
      end
    end
  end

  describe 'ログイン機能' do
    let(:user) { create(:user) }

    before do
      visit root_path
      click_button 'ログイン'
    end

    context '登録済みのユーザー' do
      it 'ログインできる' do
        within('#LoginModal') do
          fill_in 'session_email', with: user.email
          # createだと、passwordが「""」になるため
          # 直接'password'を入力している
          fill_in 'session_password', with: 'password'
          click_button 'ログイン'
        end
        expect(page).to have_content I18n.t 'user_sessions.create.success'
      end
      context '一部情報を入力していない' do
        context 'メールアドレスを入力していない' do
          it 'ログインできない' do
            within('#LoginModal') do
              fill_in 'session_email', with: nil 
              fill_in 'session_password', with: 'password'
              click_button 'ログイン'
            end
            expect(page).to have_content I18n.t 'user_sessions.create.danger'
          end
        end
        context 'passwordを入力していない' do
          it 'ログインできない' do
            within('#LoginModal') do
              fill_in 'session_email', with: user.email
              fill_in 'session_password', with: nil 
              click_button 'ログイン'
            end
            expect(page).to have_content I18n.t 'user_sessions.create.danger'
          end
        end
      end
      context '属性が間違っている' do
        context 'メールアドレスが間違っている' do
          it 'ログインできない' do
            within('#LoginModal') do
              fill_in 'session_email', with: 'test@example.com'
              fill_in 'session_password', with: 'password'
              click_button 'ログイン'
            end
            expect(page).to have_content I18n.t 'user_sessions.create.danger'
          end
        end
        context 'passwordが間違っている' do
          it 'ログインできない' do
            within('#LoginModal') do
              fill_in 'session_email', with: user.email 
              fill_in 'session_password', with: 'foobar'
              click_button 'ログイン'
            end
            expect(page).to have_content I18n.t 'user_sessions.create.danger'
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

      context 'topページ' do
        it 'ログアウトできる' do
          click_link 'ログアウト'
          expect(page).to have_content I18n.t 'user_sessions.destroy.success'
        end
      end
    end
  end
end
