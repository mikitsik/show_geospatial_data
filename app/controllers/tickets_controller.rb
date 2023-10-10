class TicketsController < ApplicationController
  def index
    @tickets = Ticket.includes(:excavator)
  end

  def show
    @ticket = TicketPresenter.new(
      Ticket.includes(:excavator).find(params[:id])
    )
  end
end
