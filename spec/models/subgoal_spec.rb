require 'rails_helper'

RSpec.describe Subgoal, type: :model do
  describe 'インスタンスメソッド' do
    let(:user) { create(:user, :with_goal_and_subgoal) }
    let(:goal) { user.goals.first }
    let(:subgoal) { goal.subgoals.first }

    it 'create後のステータスは「Run」である事' do
      expect(subgoal.status).to eq 'run'
    end
    it 'done後のステータスは「Done」である事' do
      subgoal.done
      expect(subgoal.status).to eq 'done' 
    end
    it 'expired後のステータスは「Expired」である事' do
      subgoal.expired
      expect(subgoal.status).to eq 'expired'
    end
    it 'run後のステータスは「Expired」である事' do
      subgoal.run
      expect(subgoal.status).to eq 'run'
    end
  end
end
