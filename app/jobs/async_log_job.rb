class AsyncLogJob < ApplicationJob
  queue_as :default

  def perform(model=nil)
    if !model.nil?
      # Do something later
      # 5分過ぎた状態で実行
      # タスクのIDからタスクを取得
      task = Task.find_by_id(model.id)
      current_time = Time.zone.now
      # statuが'run'の場合statusを'expird'に更新
      puts '入った'
      if task && task.run?
        puts task.status
      # 現在の時刻とtaskの時間を比較し現在の時刻のほうが未来ならば下記を実行(更新時実行されなくなる)
        unless current_time < task.reminder
          task.expired!
          puts task.status
        end
      else
        puts "削除されたタスク"
      end
    else
      puts 'modelがnilだったよ!'
    end
    # 更新時はjobをupdateメソッド内でjobを時間指定で呼び出す
    # 次の日にスケジューリングされる
  end
end
