class OrdersController < ApplicationController
  before_action :check_login
  def check_login
    redirect_to member_session_path and return unless current_member
  end
  before_action :set_order, only: %i[ edit_status update destroy ]

  # GET /orders or /orders.json
  def index
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

  
  # GET /orders/1 or /orders/1.json
  def show
    redirect_to root_path, alert: "You are not authorised to view that page."
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
    redirect_to root_path, alert: "You are not authorised to view that page."
  end

  def edit_status
    redirect_to root_path, alert: "You are not authorised to view that page." unless current_member.is_admin?
    if request.patch?
      if params[:commit] == "Reject Request"
        @order.update(approver: current_member, deadline: Time.now, returned: true)
        redirect_to club_path(current_member.club), notice: "The Order Request was rejected successfully."
      else
        @order.update(approver: current_member, deadline: params[:deadline], returned: false, approved_at: Time.current)
        redirect_to club_path(current_member.club), notice: "The Order Request was accepted successfully."
      end
    end
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(
      quantity:params[:order][:quantity],
      item_id:params[:order][:item_id],
      requester: current_member,
      requested_at:Time.now,
      approver:Member.find(1),
      approved_at: nil,
      deadline: nil,
      returned:false)

    respond_to do |format|
      if @order.save
        #it may become negative to simulate real life scenarios
        @item = @order.item
        @item.update(units:@item.units-@order.quantity)
        format.html { redirect_to orders_path, notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    redirect_to root_path, alert: "You are not authorised to view that page." unless current_member.is_admin?
    unless request.get?
      if params[:commit] == "Reject Request"
        @order.update(approver: current_member, deadline: Time.now, returned: true)
        redirect_to club_path(current_member.club), notice: "The Order Request was rejected successfully."
      else
        @order.update(approver: current_member, deadline: params[:order][:deadline], returned: false, approved_at: Time.current)
        redirect_to club_path(current_member.club), notice: "The Order Request was accepted successfully."
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:item_id, :requester, :requested_at, :approver, :approved_at, :deadline, :returned, :quantity)
    end
end
