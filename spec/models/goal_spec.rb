require 'rails_helper'

RSpec.describe Goal, type: :model do
  let(:user) { create(:user) }
  let(:goal_active) { build(:goal, :active, :association, user: user) }
  let(:goal_inactive) { build(:goal, :inactive, :association, user: user) }
  let(:goal_user_id_nil_active) { build(:goal, :active)  }
  let(:goal_user_id_nil_inactive) { build(:goal, :inactive)  }

  context 'ステータスが実行中の時' do
    xit '具体化、定量化、単位、行動があれば有効な状態であること' do
      expect(goal_active).to be_valid
    end
    xit '定量化がなければ無効な状態であること' do
      goal_active.quantification = nil
      goal_active.valid?
      expect(goal_active.errors[:quantification]).to include(I18n.t('errors.messages.blank'))
    end
    xit '具体化がなければ無効な状態であること' do
      goal_active.embodiment = nil
      goal_active.valid?
      expect(goal_active.errors[:embodiment]).to include(I18n.t('errors.messages.blank'))
    end
    xit '単位にがなければ無効な状態であること' do
      goal_active.unit = nil
      goal_active.valid?
      expect(goal_active.errors[:unit]).to include(I18n.t('errors.messages.blank'))
    end
    xit '行動がなければ無効な状態であること' do
      goal_active.what_to_do = nil
      goal_active.valid?
      expect(goal_active.errors[:what_to_do]).to include(I18n.t('errors.messages.blank'))
    end
    xit 'user_idがなければ無効な状態であること' do
      goal_user_id_nil_active.user_id = nil
      goal_user_id_nil_active.valid?
      expect(goal_user_id_nil_active.errors[:user]).to include(I18n.t('errors.messages.blank'))
    end
  end
end
