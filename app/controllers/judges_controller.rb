class JudgesController < ApplicationController
  before_action :authorize_admin

  def index
    @judges = User.where(role: 'judge')
  end

  def new
    @user = User.new(role: 'judge')
  end
end
