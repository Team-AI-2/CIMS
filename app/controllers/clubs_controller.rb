class ClubsController < ApplicationController
  before_action :check_login
  before_action :check_admin, only: %i[ show edit update destroy ] 
  def check_login
    redirect_to member_session_path and return unless current_member
  end
  before_action :set_club, only: %i[ show edit update destroy ]

  # GET /clubs/1 or /clubs/1.json
  def show
    @all_orders = Order.where(item_id: @club.items.pluck(:id))
    @all_items = @club.items
    @all_members = @club.members
  end

  # GET /clubs/new
  def new
    @club = Club.new
  end

  # GET /clubs/1/edit
  def edit
  end

  # POST /clubs or /clubs.json
  def create
    @club = Club.new(club_params)

    respond_to do |format|
      if @club.save
        format.html { redirect_to @club, notice: "Club was successfully created." }
        format.json { render :show, status: :created, location: @club }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clubs/1 or /clubs/1.json
  def update
    respond_to do |format|
      if @club.update(club_params)
        format.html { redirect_to @club, notice: "Club was successfully updated." }
        format.json { render :show, status: :ok, location: @club }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clubs/1 or /clubs/1.json
  def destroy
    @club.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Club was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club
      @club = Club.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def club_params
      params.require(:club).permit(:name, :room_name)
    end

    # params : {
    #   club : {
    #     name, room_name,....
    #   }, commit: "sdsdsd"
    # }

    # request: {
    #   metadata: {},
    #   ....
    #   params: {id, name, room_name},
    #   format:
    #   method:
    # }

    def check_admin
      if current_member.is_admin? 
        redirect_to root_path,alert:"You are not authorized to view this page."
        return
      end  
    end
end
