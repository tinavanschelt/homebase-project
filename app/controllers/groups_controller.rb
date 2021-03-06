class GroupsController < ApplicationController
  before_action :ensure_signed_in
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    if current_user.admin? 
      @groups = Group.all
    else
      @groups = current_user.groups
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    if @group.admin?(current_user)
      if @group.group_members.length > 0
        @members = @group.group_members.map { |m| { id: m.user_id, active: m.active, email: m.user.email }}
      else
        @members = []
      end
      @invitations = @group.invitations.unaccepted || []
    else
      redirect_to groups_path
    end
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        code = SecureRandom.hex(6)
        @group.update(access_code: code)
        @group.add_admin(current_user)
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:title, :group_type)
    end
end
