require 'rails_helper'

RSpec.describe "Goals", type: :system do
  describe 'ゴール新規作成' do
    before do
      @user = create(:user)
      login_as @user
    end
    context '成功をテスト' do
      context 'すべての項目入力' do
        it '登録成功する' do
          visit new_goal_path
          fill_in Goal.human_attribute_name(:what_to_do), with: 'webエンジニアになる'
          select '１ヶ月後', from: "goal[selectbox_parameter]" 
          fill_in 'goal_quantification', with: 1
          fill_in 'goal_unit', with: '社'
          fill_in 'goal_embodiment', with: '内定'
          click_button('登録する')
          expect(page).to have_content '目標を作成しました'
          expect(current_path).to eq goals_path
        end
      end
    end
    context '失敗をテスト' do
      context '最終目標をnilの状態で登録する' do
        it '登録失敗する' do
          visit new_goal_path
          select '１ヶ月後', from: "goal[selectbox_parameter]" 
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
          select '１ヶ月後', from: "goal[selectbox_parameter]" 
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
          select '１ヶ月後', from: "goal[selectbox_parameter]" 
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
          select '１ヶ月後', from: "goal[selectbox_parameter]" 
          fill_in 'goal_quantification', with: 1
          fill_in 'goal_unit', with: '社'
          click_button('登録する')
          expect(page).to have_content '目標を作成できませんでした'
        end
      end
    end
  end
  describe '目標更新' do
  end
end
