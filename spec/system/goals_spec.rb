require 'rails_helper'
RSpec.describe "Goals", type: :system do
  describe '目標' do
    describe '目標新規作成' do
      before do
        @user = create(:user)
        login_as @user
      end
      context '成功をテスト' do
        context 'すべての項目入力' do
          it '登録成功する' do
            visit new_goal_path
            fill_in Goal.human_attribute_name(:what_to_do), with: 'webエンジニアになる'
            select '1ヶ月後', from: "goal[deadline_on]" 
            fill_in 'goal_quantification', with: 1
            fill_in 'goal_unit', with: '社'
            fill_in 'goal_embodiment', with: '内定'
            click_button('登録する')
            expect(page).to have_content '目標を作成しました'
            expect(current_path).to eq goal_path(@user.goals.first)
          end
        end
      end
      context '失敗をテスト' do
        context '最終目標をnilの状態で登録する' do
          it '登録失敗する' do
            visit new_goal_path
            select '1ヶ月後', from: "goal[deadline_on]" 
            fill_in 'goal_quantification', with: 1
            fill_in 'goal_unit', with: '社'
            fill_in 'goal_embodiment', with: '内定'
            click_button('登録する')
            expect(page).to have_content '目標を作成できませんでした'
          end
        end
        context '期限をnilの状態で登録する' do
          it '登録失敗する' do
            visit new_goal_path
            fill_in Goal.human_attribute_name(:what_to_do), with: 'webエンジニアになる'
            fill_in 'goal_quantification', with: 1
            fill_in 'goal_unit', with: '社'
            fill_in 'goal_embodiment', with: '内定'
            click_button('登録する')
            expect(page).to have_content '目標を作成できませんでした'
          end
        end
        context '定量化をnilの状態で登録する' do
          it '登録失敗する' do
            visit new_goal_path
            fill_in Goal.human_attribute_name(:what_to_do), with: 'webエンジニアになる'
            select '1ヶ月後', from: "goal[deadline_on]" 
            fill_in 'goal_unit', with: '社'
            fill_in 'goal_embodiment', with: '内定'
            click_button('登録する')
            expect(page).to have_content '目標を作成できませんでした'
          end
        end
        context '単位をnilの状態で登録する' do
          it '登録失敗する' do
            visit new_goal_path
            fill_in Goal.human_attribute_name(:what_to_do), with: 'webエンジニアになる'
            select '1ヶ月後', from: "goal[deadline_on]" 
            fill_in 'goal_quantification', with: 1
            fill_in 'goal_embodiment', with: '内定'
            click_button('登録する')
            expect(page).to have_content '目標を作成できませんでした'
          end
        end
        context '具体化をnilの状態で登録する' do
          it '登録失敗する' do
            visit new_goal_path
            fill_in Goal.human_attribute_name(:what_to_do), with: 'webエンジニアになる'
            select '1ヶ月後', from: "goal[deadline_on]" 
            fill_in 'goal_quantification', with: 1
            fill_in 'goal_unit', with: '社'
            click_button('登録する')
            expect(page).to have_content '目標を作成できませんでした'
          end
        end
      end
    end
    describe '目標編集機能' do
      before do
        @user2 = create(:user, :with_goals)
        login_as @user2
      end
      context '期限を1ヶ月延ばす' do
        it '期限が1ヶ月伸びて保存される' do
          visit edit_goal_path(@user2.goals.first) 
          select '1ヶ月'
          click_button('更新する')
          # 登録したデータから、1ヶ月になっているか
          expect(page).to have_content ((Date.tomorrow >> 2) - (Date.today)).to_i.to_s 
        end
      end
      describe '目標削除機能' do
        it '目標を削除される' do
          visit goal_path(@user2.goals.first)
          click_link '削除'
          expect(page).to have_content '目標を削除しました'
        end
      end
    end
  end
end
