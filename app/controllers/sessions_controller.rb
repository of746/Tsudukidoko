class SessionsController < Devise::SessionsController
  def guest_sign_in
  user = User.find_by(email: 'guest@example.com')

  unless user
    redirect_to root_path, alert: "ゲストユーザーが存在しません"
    return
  end

  sign_in(:user, user)   # スコープを明示
    redirect_to seriesbooks_path, notice: "ゲストユーザーとしてログインしました"
  end
end


