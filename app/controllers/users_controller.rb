class UsersController < Clearance::UsersController
  skip_before_action :redirect_signed_in_users

  def create
    @user = user_from_params

    if @user.save
      sign_in @user unless current_user.admin?
      flash[:notice] = t('.created')
      redirect_back_or url_after_create
    else
      render template: 'users/new', status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :name, :role)
  end

  def url_after_create
    judges_path if signed_in? && current_user.admin?
  end
end
