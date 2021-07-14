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
    let(:task) { 'status_expired:expired!' }
    it 'is succeed.' do
      # 呼び出せたかどうか
      expect(@rake[task].invoke).to be_truthy
    end
  end
end
