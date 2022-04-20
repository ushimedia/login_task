class UsersController < ApplicationController
    skip_before_action :login_required, only: [:new, :create]
    before_action :correct_user, only: [:show]

    def new
        @user = User.new
      end

      def show
        @user = User.find(params[:id])
      end

      def edit
     
      end

      def create
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = 'アカウントを登録しました'

            log_in(@user)
            redirect_to user_path(@user.id)
            flash[:notice] = 'ログインしました'
        else
          render :new
        end
      end
    
      private
    
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end

      def correct_user
        @user = User.find(params[:id])
        redirect_to current_user unless current_user?(@user)
      end

    end
