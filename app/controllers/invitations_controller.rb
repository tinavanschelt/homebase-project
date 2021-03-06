class InvitationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_invitation, only: [:edit, :update, :destroy]

  # GET /invitations/1
  # GET /invitations/1.json
  def show
    return redirect_to new_user_registration_path(code: params[:id]) if params[:id].present?
    redirect_to root_path
  end

  # GET /invitations/new
  def new
    @invitation = Invitation.new
  end

  # GET /invitations/1/edit
  def edit
  end

  # POST /invitations
  # POST /invitations.json
  def create
    @invitation = Invitation.new(invitation_params)

    if @invitation.save
      InvitationMailer.invite_member(@invitation)
      render json: { email: @invitation.email, id: @invitation.id, status: :ok }
    else
      render json: { errors: @invitation.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /invitations/1
  # PATCH/PUT /invitations/1.json
  def update
    respond_to do |format|
      if @invitation.update(invitation_params)
        format.html { redirect_to @invitation, notice: 'Invitation was successfully updated.' }
        format.json { render :show, status: :ok, location: @invitation }
      else
        format.html { render :edit }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invitations/1
  # DELETE /invitations/1.json
  def destroy
    email = @invitation.email
    if @invitation.destroy
      render json: { email: @invitation.email, id: @invitation.id }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invitation
      @invitation = Invitation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def invitation_params
      params.require(:invitation).permit(:group_id, :user_id, :accepted, :email)
    end
end
