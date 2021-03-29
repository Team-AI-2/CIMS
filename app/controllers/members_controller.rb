
class MembersController < ApplicationController
  before_action :check_login
  def check_login
    redirect_to member_session_path and return unless current_member
  end
  before_action :set_club, only: %i[ show edit update destroy ]

  # GET /members/my_dashboard
  def my_dashboard
    @club = current_member.club
    @order_history_approved = Order.where(requester_id: current_member.id,
                                          returned: false)
                                    .where.not(approved_at: nil)
    @order_history_requested = Order.where(requester_id: current_member.id,
                                           approved_at: nil)
    @order_history_returned = Order.where(requester_id: current_member.id,
                                          returned: true)
                                   .where.not(approved_at: nil)
  end

  def new_member; end
  def destroy; end
  private

  # Only allow a list of trusted parameters through.
  def member_params
    params.require(:member)
  end
end
