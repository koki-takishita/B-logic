namespace :status_expired do
  desc "statusをexpiredへ変更"
    def current_of_the_day
      year = Time.zone.now.year
      month = Time.zone.now.month
      day = Time.zone.now.day
      time = Time.zone.local(year, month, day)
    end

    def models_hash
      ["Goal", "Subgoal"].map{|model| model.constantize}
    end


  task expired!: :environment do
    enum_run = 0
    goals = Goal.all.select{|goal|
      goal.run? && goal.deadline < current_of_the_day
    }
    # ステータスをexpirdに更新 
    if !goals.nil?
      goals.each{|goal|
        goal.expired!
      }
    end
  end
end
