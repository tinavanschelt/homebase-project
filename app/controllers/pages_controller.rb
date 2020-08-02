class PagesController < ApplicationController
  before_action :ensure_signed_in
  
  def dashboard
  end
end
