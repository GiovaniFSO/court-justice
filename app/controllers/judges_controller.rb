class JudgesController < ApplicationController
  before_action :authorize_admin
  before_action :set_judge, only: %i[edit update]

  def index
    @judges = User.where(role: 'judge')
  end

  def new
    @user = User.new(role: 'judge')
  end

  def edit; end

  def update
    if @judge.update(judge_params)
      redirect_to judges_path, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_judge
    @judge = User.find(params[:id])
  end

  def judge_params
    params.require(:user).permit(:name, :username, :email)
  end
end
