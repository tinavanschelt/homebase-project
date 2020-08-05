class PagesController < ApplicationController
  before_action :ensure_signed_in
  
  def dashboard
    @groups = current_user.groups
    @group = @groups.length > 0 ? current_user.groups.first : nil
    @events = @group.events
    @tasks = @group.tasks
  end
end
