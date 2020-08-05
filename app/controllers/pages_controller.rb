class PagesController < ApplicationController
  before_action :ensure_signed_in
  
  def dashboard
    @groups = current_user.groups
    @group = @groups.length > 0 ? current_user.primary_group : nil
    if @group.present?
      @events = @group.events.order(start_time: :desc)[0...5]
      @tasks = @group.tasks.order(due_at: :desc)[0...5]
    end
  end
end
