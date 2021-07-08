module Status
  extend ActiveSupport::Concern

  def done
  # 属性ではなく、ローカル変数になってしまう
    # status = :done
    self.status = :done
  end

  def expired
    self.status = :expired
  end

  def run
    self.status = :run
  end

end
