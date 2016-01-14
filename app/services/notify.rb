class Notify

  def initialize(from, to)
    @from = from
    @to = to
  end

  def notify!(description)
    attributes = {from: @from, to: @to, description: description}
    Notification.create!(attributes)
  end

end

