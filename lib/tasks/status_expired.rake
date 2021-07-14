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
    enum_run = 1
    objects = models_hash.map{|model|
      model.where("status = ? and deadline_on < ?", enum_run, current_of_the_day)
    }
    objects.each{ |object| object.expired! if object.present? }
  end
end
