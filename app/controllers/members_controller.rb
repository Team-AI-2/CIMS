
class MembersController < ApplicationController
  before_action :check_login
  def check_login
    redirect_to member_session_path and return unless current_member
  end
  before_action :set_club, only: %i[ show edit update destroy ]

  # GET /members/my_dashboard
  def my_dashboard
    @club = current_member.club
    @order_history_requested = Order.where(requester_id: current_member.id,
                                           approved_at: nil)
  end

  def new_member; end
  def destroy_member
    Member.find(params[:id]).update(active: false)
    redirect_to club_path(current_member.club.id)
  end
  private

  # Only allow a list of trusted parameters through.
  def member_params
    params.require(:member)
  end
end
