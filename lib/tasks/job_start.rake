namespace :job_start do
  desc "タスクのremindから時間を指定してjobを起動する"
  task task_status_check: :environment do
    # タスクを全件取得
    tasks = Task.all
    # 一つずつ取り出してremindを取得し変数に格納
    tasks.each{ |task|
      task.run!
      time = task.reminder
      puts task

      year = Time.zone.now.year
      month = Time.zone.now.month
      day = Time.zone.now.day
      hour = time.hour
      minute = (time + 1.minute).min

      # これだと日付指定になっているため、過去の日付のものだとチェックが入らなくなる
      # 今日の日付 + 指定した時間で毎回生成することで、毎日チェックが入るようになる
      on_time = Time.zone.local(year, month, day, hour, minute) 
      puts on_time
      AsyncLogJob.set(wait_until: on_time).perform_later(task)
    }
    
    # 時間を指定してjobを呼び出す(eachの中)
    # update時はupdateメソッド内で(remind)の時間を指定して直接呼び出す
  end
end
