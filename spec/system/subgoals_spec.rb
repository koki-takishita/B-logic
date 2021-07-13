require 'rails_helper'
RSpec.describe "Subgoals", type: :system do
  describe 'サブ目標新規作成' do
    before do
      @user = create(:user, :with_goals_next_month)
      login_as @user
      visit goal_path(@user.goals.first)
    end
    context 'すべての項目入力' do
      it '登録成功する' do
        visit new_subgoal_path
        fill_in Subgoal.human_attribute_name(:subgoal), with: 'たくさん学習する'
        select '1ヶ月後', from: "subgoal[deadline_on]"
        fill_in 'subgoal_quantification', with: 8
        fill_in 'subgoal_unit', with: '時間'
        fill_in 'subgoal_embodiment', with: '学習'
        click_button '登録する'
        expect(page).to have_content 'サブ目標を作成しました'
        expect(current_path).to eq goal_path(@user.goals.first)
      end
    end
    context '期限をnilの状態で登録する' do
      it '登録失敗する' do
        visit new_subgoal_path
        fill_in Subgoal.human_attribute_name(:subgoal), with: 'たくさん学習する'
        fill_in 'subgoal_quantification', with: 8
        fill_in 'subgoal_unit', with: '時間'
        fill_in 'subgoal_embodiment', with: '学習'
        click_button '登録する'
        expect(page).to have_content 'サブ目標を作成できませんでした'
      end
    end
    context '定量化をnilの状態で登録する' do
      it '登録失敗する' do
        visit new_subgoal_path
        fill_in Subgoal.human_attribute_name(:subgoal), with: 'たくさん学習する'
        select '1ヶ月後', from: "subgoal[deadline_on]"
        fill_in 'subgoal_unit', with: '時間'
        fill_in 'subgoal_embodiment', with: '学習'
        click_button '登録する'
        expect(page).to have_content 'サブ目標を作成できませんでした'
      end
    end
    context '単位をnilの状態で登録する' do
      it '登録失敗する' do
        visit new_subgoal_path
        fill_in Subgoal.human_attribute_name(:subgoal), with: 'たくさん学習する'
        select '1ヶ月後', from: "subgoal[deadline_on]"
        fill_in 'subgoal_quantification', with: 8
        fill_in 'subgoal_embodiment', with: '学習'
        click_button '登録する'
        expect(page).to have_content 'サブ目標を作成できませんでした'
      end
    end
    context '具体化をnilの状態で登録する' do
      it '登録失敗する' do
        visit new_subgoal_path
        fill_in Subgoal.human_attribute_name(:subgoal), with: 'たくさん学習する'
        select '1ヶ月後', from: "subgoal[deadline_on]"
        fill_in 'subgoal_quantification', with: 8
        fill_in 'subgoal_unit', with: '時間'
        click_button '登録する'
        expect(page).to have_content 'サブ目標を作成できませんでした'
      end
    end
    context 'サブ目標をnilの状態で登録する' do
      it '登録失敗する' do
        visit new_subgoal_path
        select '1ヶ月後', from: "subgoal[deadline_on]"
        fill_in 'subgoal_quantification', with: 8
        fill_in 'subgoal_unit', with: '時間'
        fill_in 'subgoal_embodiment', with: '学習'
        click_button '登録する'
        expect(page).to have_content 'サブ目標を作成できませんでした'
      end
    end
  end
  describe 'サブ目標編集機能' do
    before do
      @user = create(:user, :with_goal_and_subgoal)
      login_as @user
      visit goal_path(@user.goals.first)
      visit subgoal_path(@user.goals.first.subgoals.first)
    end
    context '期限を１か月延ばす' do
      it '期限が１か月伸びて保存される' do
        visit edit_subgoal_path(@user.goals.first.subgoals.first)
        select '1ヶ月後'
        click_button('更新する')
        expect(page).to have_content ((Date.tomorrow >> 1) - (Date.today)).to_i.to_s
      end
    end
  end
end
