require 'rails_helper'

RSpec.describe Goal, type: :model do
  let(:user) { create(:user) }
  let(:goal_active) { build(:goal, :active, :association, user: user) }
  let(:goal_inactive) { build(:goal, :inactive, :association, user: user) }
  let(:goal_user_id_nil_active) { build(:goal, :active)  }
  let(:goal_user_id_nil_inactive) { build(:goal, :inactive)  }

  # 締切を設定した状態で目標を作成すると,ステータスが「実行中」になる
  # 締切を設定しないと、ステータスは「停止中」になる
  context 'ステータスが実行中の時' do
    it '具体化、定量化、単位、行動があれば有効な状態であること' do
      expect(goal_active).to be_valid
    end
    it '定量化がなければ無効な状態であること' do
      goal_active.quantification = nil
      goal_active.valid?
      expect(goal_active.errors[:quantification]).to include(I18n.t('errors.messages.blank'))
    end
    it '具体化がなければ無効な状態であること' do
      goal_active.embodiment = nil
      goal_active.valid?
      expect(goal_active.errors[:embodiment]).to include(I18n.t('errors.messages.blank'))
    end
    it '単位にがなければ無効な状態であること' do
      goal_active.unit = nil
      goal_active.valid?
      expect(goal_active.errors[:unit]).to include(I18n.t('errors.messages.blank'))
    end
    it '行動がなければ無効な状態であること' do
      goal_active.what_to_do = nil
      goal_active.valid?
      expect(goal_active.errors[:what_to_do]).to include(I18n.t('errors.messages.blank'))
    end
    it 'user_idがなければ無効な状態であること' do
      goal_user_id_nil_active.user_id = nil
      goal_user_id_nil_active.valid?
      expect(goal_user_id_nil_active.errors[:user]).to include(I18n.t('errors.messages.blank'))
    end
  end
  context 'ステータスが停止中の時' do
    it '具体化、定量化、単位、行動があれば有効な状態であること' do
      expect(goal_inactive).to be_valid
    end
    it '具体化がなくても有効な状態であること' do
      goal_inactive.embodiment = nil
      expect(goal_inactive).to be_valid
    end
    it '定量化がなくても有効な状態であること' do
      goal_inactive.quantification = nil
      expect(goal_inactive).to be_valid
    end
    it '単位がなくても有効な状態であること' do
      goal_inactive.unit = nil
      expect(goal_inactive).to be_valid
    end
    it '行動がなくても有効な状態であること' do
      goal_inactive.what_to_do = nil
      expect(goal_inactive).to be_valid
    end
    it '具体化、定量化、単位、行動(すべての入力項目)がなければ無効な状態であること' do
      goal_inactive.embodiment = nil
      goal_inactive.quantification = nil
      goal_inactive.unit = nil
      goal_inactive.what_to_do = nil
      goal_inactive.valid?
      expect(goal_inactive.errors[:input_all_attributes]).to include(I18n.t('errors.messages.input_attributes_blank'))
    end
    it 'user_idがなければ無効な状態であること' do
      goal_user_id_nil_inactive.valid?
      expect(goal_user_id_nil_inactive.errors[:user]).to include(I18n.t('errors.messages.blank'))
    end
  end
end
