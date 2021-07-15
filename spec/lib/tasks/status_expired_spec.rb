require 'rails_helper'
require 'rake'

describe 'rake task status_expired' do
  before(:all) do
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require 'tasks/status_expired'
    Rake::Task.define_task(:environment)
  end

  before(:each) do
    @rake[task].reenable
  end

  describe 'status_expired:expired!' do
    include TimeMethods

    let(:task) { 'status_expired:expired!' }
    let(:user) { create(:user) }
    let(:goal_now_run) { create(:goal, :goal_run, deadline_on: tense_of_the_time(:now), user: user) }
    let(:goal_past_run) { create(:goal, :goal_run, deadline_on: tense_of_the_time(:past), user: user) }
    let(:goal_feature_run) { create(:goal, :goal_run, deadline_on: tense_of_the_time(:feature), user: user) }
    let(:goal_past_done) { create(:goal, :goal_done, deadline_on: tense_of_the_time(:past), user: user) }
    let(:goal_past_expired) { create(:goal, :goal_expired, deadline_on: tense_of_the_time(:past), user: user) }

    let(:subgoal_now_run) { create(:subgoal, :subgoal_run, deadline_on: tense_of_the_time(:now), goal: goal_feature_run) }
    let(:subgoal_past_run) { create(:subgoal, :subgoal_run, deadline_on: tense_of_the_time(:past), goal: goal_feature_run) }
    let(:subgoal_feature_run) { create(:subgoal, :subgoal_run, deadline_on: tense_of_the_time(:feature), goal: goal_feature_run) }
    let(:subgoal_past_done) { create(:subgoal, :subgoal_done, deadline_on: tense_of_the_time(:past), goal: goal_feature_run) }
    let(:subgoal_past_expired) { create(:subgoal, :subgoal_expired, deadline_on: tense_of_the_time(:past), goal: goal_feature_run) }

    def date_create
      goal_now_run
      goal_past_run
      goal_feature_run
      goal_past_done
      goal_past_expired
      subgoal_now_run
      subgoal_past_run
      subgoal_feature_run
      subgoal_past_done
      subgoal_past_expired
    end

    it 'is succeed.' do
      # 呼び出せたかどうか
      expect(@rake[task].invoke).to be_truthy
    end
    it 'status=expiredが2件ある' do
      date_create
      @rake[task].invoke
      expect(Goal.where(status: 2).count).to eq 2
      expect(Subgoal.where(status: 2).count).to eq 2
    end
  end
end
