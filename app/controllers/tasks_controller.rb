class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle_complete]
  before_action :set_group, only: [:index, :show, :new]
  before_action :set_members, only: [:show, :edit, :new]

  # GET /tasks
  # GET /tasks.json
  def index
    if @group.present?
      @tasks = @group.tasks
    else
      redirect_to root_path
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    redirect_to root_path if @group.nil?
  end

  # GET /tasks/new
  def new
    redirect_to root_path if @group.nil?
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    # add completed_at timestamp when task is marked complete
    is_completed = task_params["completed"] == "1"
    if(is_completed && @task.completed != is_completed)
      complete_params = task_params.merge(completed_at: DateTime.now)
    else
      complete_params = task_params
    end

    respond_to do |format|
      if @task.update(complete_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_complete
    if @task.update_attribute(:completed, params["completed"])
      render json: { status: :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def set_members
      if current_group.present?
        active_members = current_group.group_members.where(active: true)
        @members = active_members.map { |m| ["#{m.user.full_name}", "#{m.user_id}"]}
      else
        @members = nil
      end
    end

    def set_group
      @groups = current_user.groups

      if @groups.length > 0
        @group = current_user.primary_group
      else
        @group = nil
      end
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:user_id, :group_id, :assigned_to, :title, :description, :due_at, :completed_at, :completed, :completed_by, :restricted)
    end
end
