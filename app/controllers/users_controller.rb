class UsersController < ApplicationController


    #delete this test!
    def something
    end

    def index
        session[:user_id] = nil
    end

    def register
        user = User.new(user_params)
        if user.save
            session[:user_id] = user.id
            redirect_to "/testindex"
            # redirect_to groups_path
        else
            flash[:errors] = user.errors.full_messages
            redirect_to root_path
        end
    end

    def login 
        @usr = User.find_by_email(params[:user][:email]).try(:authenticate, params[:user][:password])
        if @usr
            session[:user_id] = @usr.id
            redirect_to "/testindex"
            # redirect_to groups_path
            
        else 
            flash[:errors] = ["Invalid combination"]
            redirect_to root_path
        end
    end

    def result
        if not_current_user
            logout
        end
    end

    def logout
        session[:user_id] = nil
        redirect_to root_path
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
