class SessionsController < ApplicationController
    skip_before_action :login_required, only: [:new, :create]
    
    def new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user&.authenticate(params[:session][:password])
            # ログイン成功した場合
            log_in(user)
            redirect_to user_path(user.id)
          else
            flash.now[:danger] = 'メールアドレスまたはパスワードに誤りがあります'
            render :new
          end
        end

    def destroy
            session.delete(:user_id)
            flash[:notice] = 'ログアウトしました'
            redirect_to new_session_path
          end


end
