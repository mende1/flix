class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to movies_path, notice: "Welcome back, #{user.name}!"
    else
      flash.now[:alert] = "Invalid email/password combination!"

      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)

    redirect_to movies_url, status: :see_other,
                alert: "You're now sign out!"
  end
end
