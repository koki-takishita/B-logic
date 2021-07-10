# frozen_string_literal: true

module SubgoalDecorator

  def subgoal_deadline(object)
    select = {'１ヶ月後'=> 1, '２ヶ月後'=> 2, '３ヶ月後'=> 3, '４ヶ月後'=> 4, '５ヶ月後'=> 5, '半年後'=> 6, 'これ以上期限を延ばす場合は目標の期限を延ばしてください' => 0 }
    # goalをもとに何ヶ月伸ばせるかがわかる
    deadline = delivery_time_to_month(object)
    select_form = select.select{|key, value| deadline.to_i >= value.to_i}
  end

  def delivery_time_to_month(object)
    day = ApplicationController.helpers.days_left(object.deadline_on)
    if object.respond_to?(:goal)
      day= ApplicationController.helpers.days_left(object.goal.deadline_on)
      dec_day = ApplicationController.helpers.days_left(object.deadline_on)
      day = day.to_i - dec_day.to_i
    end
    month = if day.to_i >= (Date.today.next_month - Date.today).to_i
      one_month = (Date.today.next_month - Date.today).to_i
      month = day.to_i.divmod(one_month)
      # 余り格納 save時に使用する
      # hiddenfieldで保持
      self.division_remainder = month[1]
      month[0]
    else
      division_remainder = day
      '0'
    end
  end

end
