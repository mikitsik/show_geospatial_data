class TicketPresenter
  attr_accessor :ticket

  def initialize(ticket)
    @ticket = ticket
  end

  def data
    ticket.data
  end

  def excavator
    ticket.excavator
  end

  def created_at
    ticket.created_at
  end
end
