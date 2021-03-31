class ItemsController < ApplicationController
  before_action :check_login
  def check_login
    redirect_to member_session_path and return unless current_member
  end
  before_action :set_item, only: %i[ show edit update destroy ]

  # GET /items or /items.json
  def index
    @items = Item.where.not(units:0)
  end

  # GET /items/1 or /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end
  def item_history
    @current_item = Item.unscoped.find(params[:id])
    @item_history = @current_item.orders
  end  
  # POST /items or /items.json
  def create
    params[:item][:club_id] = current_member.club.id
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to items_path, notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    params[:item][:club_id] = current_member.club.id
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to items_path, notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.update(archived: true)
    respond_to do |format|
      format.html { redirect_to items_path, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.unscoped.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:name, :units, :club_id)
    end
end
