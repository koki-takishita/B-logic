module Deadline
  def days_left(day)
    today = Date.today
    sa = day.to_date - today
    int = sa.to_i
    int.to_s
  end

  def select_deadline
    persisted? ? deadline_array_edit : deadline_array_new
  end

  def association_object
    goal_object || subgoal_object
  end

  private

    def goal_object
      goal if respond_to?(:goal) || false
    end

    def subgoal_object
      subgoal if respond_to?(:subgoal) || false
    end

    # 時間を00時:00分:00秒に変換する
    def of_the_clock(type: 'weeks', i: 1, deadline: current_time)
      m = deadline.advance("#{type}": i).to_s.match(regular) 
      date(m)
    end

    def current_time
      Time.zone.now
    end

    def regular
      %r{(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2}) .+}
    end

    def date(m)
      Time.zone.local(m[:year], m[:month], m[:day])
    end

    def deadline_array_edit(deadline: deadline_on)
      hash = { '1週間': of_the_clock(i: 1, deadline: deadline), '2週間': of_the_clock(i: 2, deadline: deadline), '3週間': of_the_clock(i: 3, deadline: deadline), '1ヶ月後': of_the_clock(type: 'months', i: 1, deadline: deadline), '2ヶ月後': of_the_clock(type: 'months', i: 2, deadline: deadline),  '3ヶ月後': of_the_clock(type: 'months', i: 3, deadline: deadline), '4ヶ月後': of_the_clock(type: 'months', i: 4, deadline: deadline), '5ヶ月後': of_the_clock(type: 'months', i: 5, deadline: deadline), '6ヶ月後': of_the_clock(type: 'months', i: 6, deadline: deadline)}

      hash.store(hash_association_name_key, association_object.deadline_on) if association_object && association_object.deadline_on > deadline_on
      hash_evaluation(hash)
    end

    def deadline_array_new(deadline: deadline_on)
      hash = { '1週間': of_the_clock(i: 1), '2週間': of_the_clock(i: 2), '3週間': of_the_clock(i: 3), '1ヶ月後': of_the_clock(type: 'months', i: 1), '2ヶ月後': of_the_clock(type: 'months', i: 2),  '3ヶ月後': of_the_clock(type: 'months', i: 3), '4ヶ月後': of_the_clock(type: 'months', i: 4), '5ヶ月後': of_the_clock(type: 'months', i: 5), '6ヶ月後': of_the_clock(type: 'months', i: 6)}

      hash.store(hash_association_name_key, association_object.deadline_on) if association_object
      hash_evaluation(hash)
    end

    def hash_evaluation(hash)
      hash.select{|k, v| association_object ? association_object.deadline_on >= v : of_the_clock(type: 'months', i: 6) >= v }
    end

    def hash_association_name_key
      "#{association_name}と同じ期限"
    end

    def association_name
      self.association_object.model_name.human
    end

end
