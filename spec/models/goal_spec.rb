require 'rails_helper'

RSpec.describe Goal, type: :model do
  describe 'インスタンスメソッド' do
    let(:user) { create(:user, :with_goals) }
    let(:goal) { user.goals.first }

    it 'create後のステータスは「Run」である事' do
      expect(goal.status).to eq 'run'
    end
    it 'done後のステータスは「Done」である事' do
      goal.done
      expect(goal.status).to eq 'done' 
    end
    it 'expired後のステータスは「Expired」である事' do
      goal.expired
      expect(goal.status).to eq 'expired'
    end
    it 'run後のステータスは「Expired」である事' do
      goal.run
      expect(goal.status).to eq 'run'
    end
  end
end
